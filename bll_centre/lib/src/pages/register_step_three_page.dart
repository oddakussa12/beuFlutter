import 'package:centre/src/actuator/register_actuator.dart';
import 'package:centre/src/widget/agreement_bar_widget.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

/**
 * register_step_one_page.dart
 * 注册第三步
 *
 * @author: Ruoyegz
 * @date: 2021/7/7
 */
class RegisterStepThreePage extends StatefulWidget {
  final String phone;
  final CountryCode country;

  /// 用户名
  final String name;
  final String password;

  const RegisterStepThreePage(
      {Key? key,
      required this.phone,
      required this.country,
      required this.name,
      required this.password})
      : super(key: key);

  @override
  _RegisterStepThreePageState createState() =>
      _RegisterStepThreePageState(RegisterStepThreeActuator());
}

class _RegisterStepThreePageState
    extends ReactableState<RegisterStepThreeActuator, RegisterStepThreePage> {
  /// 昵称
  String nickName = "";

  /// 注册按钮的交互状态
  bool mutualStatus = false;

  _RegisterStepThreePageState(RegisterStepThreeActuator actuator)
      : super(actuator);

  /// 检查用户的输入并改变下一步按钮的交互状态
  void changeMutualByInput() {
    if (TextHelper.isEmpty(nickName)) {
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
    if (TextHelper.isEmpty(nickName) ||
        nickName.length < 2 ||
        nickName.length > 32) {
      toast(message: S.of(context).alltip_nikenamerule);
      return;
    }

    /// 检查手机的合法性
    actuator.startRegister(
        phone: widget.phone,
        areaCode: widget.country.areaCode,
        name: widget.name,
        nickName: nickName,
        password: widget.password,
        callback: (state) {
          navigateStepThree(state);
        });
  }

  /// 第三步
  void navigateStepThree(int state) {
    Navigator.pop(context);
    BusClient().fire(SignUpEvent());
    if (state == 1) {
      Navigator.push(context,
          PageTransition(type: TransitionType.rightToLeft, child: LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: S.of(context).login_your_name,
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

                  /// 用户昵称
                  buildNickName(context),

                  /// 下一步按钮
                  buildNextStep(context),
                ],
              ),
            ),
          ),
          AgreementBarWidget()
        ],
      ),
    );
  }

  /// Name should be between 2 to 32 characters
  Widget buildNickName(BuildContext context) {
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
            hintText: S.of(context).login_write_name,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 1,
        maxLength: 32,
        cursorColor: AppColor.colorF7551D,
        cursorWidth: 2,
        cursorRadius: Radius.circular(2),
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          if (!TextHelper.isEqual(nickName, text)) {
            nickName = text;
            changeMutualByInput();
          }
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 name 是否为空
            text: '${this.nickName == null ? "" : this.nickName}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.nickName}'.length)))),
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
