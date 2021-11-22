// TODO Implement this library.import 'package:centre/src/actuator/login_actuator.dart';
import 'package:centre/src/actuator/login_actuator.dart';
import 'package:centre/src/pages/forgot_password_step_one.dart';
import 'package:centre/src/pages/register_step_one_page.dart';
import 'package:centre/src/widget/agreement_bar_widget.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'country_code_page.dart';

/**
 * login_page.dart
 * 登录页
 *
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(LoginActuator());
}

class _LoginPageState extends ReactableState<LoginActuator, LoginPage> {
  _LoginPageState(LoginActuator actuator) : super(actuator);

  @override
  void initState() {
    super.initState();
    if (Constants.isTesting) {
      if (TextHelper.isEmpty(actuator.phone)) {
        actuator.phone = "15901230854";
      }
      if (TextHelper.isEmpty(actuator.password)) {
        actuator.password = "123456";
      }
    }
  }

  /// 接收国家区号
  void receivedCountryCode(List<CountryCode>? value) {
    LogDog.d("receivedCountryCode: ${value}");
    if (value != null && value.isNotEmpty) {
      setState(() {
        actuator.country = value[0];
      });
    }
  }

  /// 检测用户输入的信息
  /// 开始登录
  void tapLogin(BuildContext context) {
    /// 检查区号
    setState(() {
      actuator.country.code = S.of(context).ethiopian_country_code;
      actuator.country.areaCode = S.of(context).ethiopian_country_areaCode;
      actuator.country.name = S.of(context).ethiopian_country_name;
    });
    if (TextHelper.isEmpty(actuator.country.code) ||
        TextHelper.isEmpty(actuator.country.name)) {
      toast(message: S.of(context).reminder_country);
      return;
    }

    /// 检查手机号
    if (TextHelper.isEmpty(actuator.phone) ||
        actuator.phone.length < 7 ||
        actuator.phone.length > 14) {
      toast(message: S.of(context).confirm_phone_rule);
      return;
    }

    /// 检查密码
    if (TextHelper.isEmpty(actuator.password) ||
        actuator.password.length < 6 ||
        actuator.password.length > 24) {
      toast(message: S.of(context).loginerror_password);
      return;
    }

    LoadingDialog.show(context);
    FocusScope.of(context).requestFocus(FocusNode());
    actuator.login(actuator.country.areaCode, actuator.phone, actuator.password,
        (state) {
      BusClient().fire(SignInEvent());
      Navigator.pop(context);
    }, complete: () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(
          title: S.of(context).login_log_in,
        ),
        body: ListView(
          children: [
            SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: MediaQuery.of(context).size.height - 140,
                  margin: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    children: [
                      /// Logo
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 40, bottom: 40),
                        child: Image.asset(
                          "res/images/ic_launcher.png",
                          package: 'resources',
                          width: 60,
                          height: 60,
                        ),
                      ),

                      /// 区号和手机号
                      Row(
                        children: [
                          /// 区号
                          buildPhoneAreaCode(),

                          /// 手机号
                          buildPhone(context),
                        ],
                      ),

                      /// 密码框
                      buildPassword(context),

                      /// 登录按钮
                      buildLoginIn(context),
                      //  buildForgotPassword(context),

                      /// 注册分割线
                      Container(
                        height: 0.61,
                        color: AppColor.color08000,
                        margin: EdgeInsets.only(top: 16),
                      ),

                      buildRegister(context),
                    ],
                  ),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
            AgreementBarWidget(),
          ],
        ));
  }

  Widget buildPhoneAreaCode() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        padding: EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
            color: AppColor.color08000,
            border: Border.all(color: AppColor.color1A000, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              child: Text(
                "+${TextHelper.clean(S.of(context).ethiopian_country_areaCode)}",
                style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              margin: EdgeInsets.only(right: 6),
            ),
            // Image.asset(
            //   "res/icons/ic_arrow_down_red.png",
            //   package: 'resources',
            //   width: 15,
            //   height: 15,
            // ),
          ],
        ),
      ),
      // onTap: () {
      //   Navigator.push(
      //           context,
      //           PageTransition(
      //               type: TransitionType.rightToLeft, child: CountryCodePage()))
      //       .then((value) => receivedCountryCode(value));
      // },
    );
  }

  Widget buildPhone(BuildContext context) {
    return Expanded(
      child: Container(
          height: 44,
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              color: AppColor.color08000,
              border: Border.all(color: AppColor.color1A000, width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding:
                    EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
                counterText: "",
                hintText: S.of(context).reminder_enterphone,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColor.hint,
                )),
            maxLines: 1,
            maxLength: 14,
            keyboardType: TextInputType.phone,
            cursorColor: AppColor.colorF7551D,
            cursorWidth: 2,
            cursorRadius: Radius.circular(2),
            textAlign: TextAlign.left,
            style: TextStyle(color: AppColor.black, fontSize: 16),
            onChanged: (text) {
              if (!TextHelper.isEqual(actuator.phone, text)) {
                actuator.phone = text;
              }
            },
            controller: TextEditingController.fromValue(TextEditingValue(
                //判断 name 是否为空
                text:
                    '${this.actuator.phone == null ? "" : this.actuator.phone}',
                // 保持光标在最后

                selection: TextSelection.fromPosition(TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: '${this.actuator.phone}'.length)))),
          )),
    );
  }

  /// 密码：6-24 位
  Container buildPassword(BuildContext context) {
    return Container(
        height: 44,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: AppColor.color08000,
            border: Border.all(color: AppColor.color1A000, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding:
                  EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
              counterText: "",
              hintText: S.of(context).reminder_enterpassword,
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColor.hint,
              )),
          maxLines: 1,
          maxLength: 24,
          obscureText: true,
          obscuringCharacter: "•",
          cursorColor: AppColor.colorF7551D,
          cursorWidth: 2,
          cursorRadius: Radius.circular(2),
          textAlign: TextAlign.left,
          style: TextStyle(color: AppColor.black, fontSize: 16),
          onChanged: (text) {
            if (!TextHelper.isEqual(actuator.password, text)) {
              actuator.password = text;
            }
          },
          controller: TextEditingController.fromValue(TextEditingValue(
              //判断 name 是否为空
              text:
                  '${this.actuator.password == null ? "" : this.actuator.password}',
              // 保持光标在最后

              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: '${this.actuator.password}'.length)))),
        ));
  }

  Widget buildLoginIn(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
                colors: [Color(0xFFFF8913), Color(0xFFFF0080)],
                begin: FractionalOffset(1, 0),
                end: FractionalOffset(0, 1))),
        child: Text(S.of(context).login_login,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        tapLogin(context);
      },
    );
  }

  Widget buildForgotPassword(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 16),
        child: Text("Forgot password",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.colorF7551D,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: TransitionType.rightToLeft,
                child: ForgotPasswordOnePage()));
      },
    );
  }

  Widget buildRegister(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: AppColor.color1A7551D,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(S.of(context).login_creat_new_accont,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.colorF7551D,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: TransitionType.rightToLeft,
                child: RegisterStepOnePage()));
      },
    );
  }
}
