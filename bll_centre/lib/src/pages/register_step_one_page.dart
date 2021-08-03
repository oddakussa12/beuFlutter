import 'package:centre/src/actuator/register_actuator.dart';
import 'package:centre/src/pages/register_step_two_page.dart';
import 'package:centre/src/widget/agreement_bar_widget.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'country_code_page.dart';

/**
 * register_step_one_page.dart
 * 注册第一步
 *
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class RegisterStepOnePage extends StatefulWidget {
  const RegisterStepOnePage({Key? key}) : super(key: key);

  @override
  _RegisterStepOnePageState createState() =>
      _RegisterStepOnePageState(RegisterStepOneActuator());
}

class _RegisterStepOnePageState
    extends ReactableState<RegisterStepOneActuator, RegisterStepOnePage> {
  String phone = "";
  CountryCode country = CountryCode.create();

  _RegisterStepOnePageState(RegisterStepOneActuator actuator) : super(actuator);

  /// 注册按钮的交互状态
  bool mutualStatus = false;

  /// 接受区号
  void receivedCountryCode(List<CountryCode>? value) {
    LogDog.d("receivedCountryCode: ${value}");
    if (value != null && value.isNotEmpty) {
      setState(() {
        country = value[0];
        changeMutualByInput();
      });
    }
  }

  /// 检查用户的输入并改变下一步按钮的交互状态
  void changeMutualByInput() {
    if (TextHelper.isEmpty(country.code) || TextHelper.isEmpty(country.name)) {
      setState(() {
        mutualStatus = false;
      });
      return;
    }
    if (TextHelper.isEmpty(phone)) {
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
    if (TextHelper.isEmpty(country.code) || TextHelper.isEmpty(country.name)) {
      toast(message: S.of(context).reminder_country);
      return;
    }
    if (TextHelper.isEmpty(phone) || phone.length < 7 || phone.length > 14) {
      toast(message: S.of(context).confirm_phone_rule);
      return;
    }

    /// 检查手机的合法性
    actuator.checkPhone(country.areaCode, phone, navigateStepTwo);
  }

  /// 第二步
  void navigateStepTwo() {
    Navigator.push(
        context,
        PageTransition(
            type: TransitionType.rightToLeft,
            child: RegisterStepTwoPage(
              phone: phone,
              country: country,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Toolbar(
          title: S.of(context).login_signup,
        ),
        body: Column(
          children: [
            SingleChildScrollView(
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

                    /// 区号
                    buildPhoneAreaCode(),

                    /// 手机号
                    buildPhone(context),

                    /// 登录按钮
                    buildNextStep(context),
                  ],
                ),
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
        height: 42,
        margin: EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
            color: AppColor.color08000,
            border: Border.all(color: AppColor.color1A000, width: 1),
            borderRadius: BorderRadius.circular(8)),
        child: TextField(
          enabled: false,
          decoration: InputDecoration(
              suffixIconConstraints: BoxConstraints(
                maxHeight: 42,
                maxWidth: 42,
                minHeight: 42,
                minWidth: 42,
              ),
              suffixIcon: Padding(
                padding: EdgeInsets.only(left: 12, right: 12),
                child: Image.asset(
                  "res/icons/ic_arrow_down_red.png",
                  package: 'resources',
                ),
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding:
                  EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
              hintText: S.of(context).reminder_country,
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColor.hint,
              )),
          maxLines: 1,
          cursorColor: AppColor.colorF7551D,
          cursorWidth: 2,
          cursorRadius: Radius.circular(2),
          textAlign: TextAlign.left,
          style: TextStyle(color: AppColor.black, fontSize: 16),
          onChanged: (text) {
            phone = text;
          },
          controller: TextEditingController.fromValue(TextEditingValue(
              //判断 name 是否为空
              text: '${this.country.name == null ? "" : this.country.name}',
              // 保持光标在最后

              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: '${this.country.name}'.length)))),
        ),
      ),
      onTap: () {
        Navigator.push(
                context,
                PageTransition(
                    type: TransitionType.rightToLeft, child: CountryCodePage()))
            .then((value) => receivedCountryCode(value));
      },
    );
  }

  Widget buildPhone(BuildContext context) {
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
            hintText: S.of(context).reminder_enterphone,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 1,
        maxLength: 14,
        cursorColor: AppColor.colorF7551D,
        keyboardType: TextInputType.phone,
        cursorWidth: 2,
        cursorRadius: Radius.circular(2),
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          if (!TextHelper.isEqual(phone, text)) {
            phone = text;
            changeMutualByInput();
          }
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 name 是否为空
            text: '${this.phone == null ? "" : this.phone}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.phone}'.length)))),
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
