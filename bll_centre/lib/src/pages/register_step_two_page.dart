import 'package:centre/src/actuator/register_actuator.dart';
import 'package:centre/src/pages/register_step_three_page.dart';
import 'package:centre/src/widget/agreement_bar_widget.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * register_step_one_page.dart
 * 注册第一步
 *
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class RegisterStepTwoPage extends StatefulWidget {
  final String phone;
  final CountryCode country;

  const RegisterStepTwoPage(
      {Key? key, required this.phone, required this.country})
      : super(key: key);

  @override
  _RegisterStepTwoPageState createState() =>
      _RegisterStepTwoPageState(RegisterStepTwoActuator());
}

class _RegisterStepTwoPageState
    extends ReactableState<RegisterStepTwoActuator, RegisterStepTwoPage> {
  /// 用户名
  String name = "";
  String password = "";

  /// 注册按钮的交互状态
  bool mutualStatus = false;

  _RegisterStepTwoPageState(RegisterStepTwoActuator actuator) : super(actuator);

  /// 检查用户的输入并改变下一步按钮的交互状态
  void changeMutualByInput() {
    if (TextHelper.isEmpty(name)) {
      setState(() {
        mutualStatus = false;
      });
      return;
    }
    if (TextHelper.isEmpty(password)) {
      setState(() {
        mutualStatus = false;
      });
      return;
    }
    setState(() {
      mutualStatus = true;
    });
  }

  /// 下一步
  void tapNextStep(BuildContext context) {
    if (TextHelper.isEmpty(name) || name.length < 3 || name.length > 24) {
      toast(message: S.of(context).alltip_usernamerule);
      return;
    }

    if (TextHelper.isEmpty(password) ||
        password.length < 6 ||
        password.length > 24) {
      toast(message: S.of(context).loginerror_password);
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());

    /// 检查手机的合法性
    actuator.checkUserName(name, navigateStepThree);
  }

  /// 第三步
  void navigateStepThree() {
    Navigator.push(
        context,
        PageTransition(
            type: TransitionType.rightToLeft,
            child: RegisterStepThreePage(
              phone: widget.phone,
              country: widget.country,
              name: name,
              password: password,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(
          title: S.of(context).login_login_info,
        ),
        body: Column(
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

                      /// 用户名
                      buildUserName(),

                      /// 密码
                      buildPassword(context),

                      /// 下一步按钮
                      buildNextStep(context),
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

  /// Username should be within 3－24 characters, can only be English or numbers.
  Widget buildUserName() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 42,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: AppColor.color08000,
            border: Border.all(color: AppColor.color1A000, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: TextField(
          decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(
                maxHeight: 42,
                maxWidth: 42,
                minHeight: 42,
                minWidth: 42,
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding:
                  EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
              counterText: "",
              hintText: S.of(context).login_username,
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColor.hint,
              )),
          maxLines: 1,
          maxLength: 24,
          keyboardType: TextInputType.text,
          cursorColor: AppColor.colorF7551D,
          cursorWidth: 2,
          cursorRadius: Radius.circular(2),
          textAlign: TextAlign.left,
          style: TextStyle(color: AppColor.black, fontSize: 16),
          onChanged: (text) {
            if (!TextHelper.isEqual(name, text)) {
              name = text;
              changeMutualByInput();
            }
          },
          controller: TextEditingController.fromValue(TextEditingValue(
              //判断 name 是否为空
              text: '${this.name == null ? "" : this.name}',
              // 保持光标在最后

              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: '${this.name}'.length)))),
        ),
      ),
    );
  }

  /// should be between 6 to 24 characters
  Widget buildPassword(BuildContext context) {
    return Container(
      height: 44,
      margin: EdgeInsets.only(top: 10),
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
        obscuringCharacter: '•',
        obscureText: true,
        keyboardType: TextInputType.text,
        cursorColor: AppColor.colorF7551D,
        cursorWidth: 2,
        cursorRadius: Radius.circular(2),
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          if (!TextHelper.isEqual(password, text)) {
            password = text;
            changeMutualByInput();
          }
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 name 是否为空
            text: '${this.password == null ? "" : this.password}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.password}'.length)))),
      ),
    );
  }

  Widget buildNextStep(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30),
        decoration: mutualStatus
            ? BoxDecoration(
                color: AppColor.colorF7551D,
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                color: AppColor.color1A000,
                borderRadius: BorderRadius.circular(8),
              ),
        child: Text(S.of(context).button_nextstep,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        tapNextStep(context);
      },
    );
  }
}
