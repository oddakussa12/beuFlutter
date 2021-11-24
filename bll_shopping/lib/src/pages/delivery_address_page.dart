import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shopping/src/actuator/delivery_address_actuator.dart';
import 'package:shopping/src/entity/user_address.dart';

/**
 * delivery_address_page.dart
 * 编辑派送地址
 *
 * @author: Ruoyegz
 * @date: 2021/7/3
 */
class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  _DeliveryAddressPageState createState() =>
      _DeliveryAddressPageState(DeliveryAddressActuator());
}

class _DeliveryAddressPageState
    extends RetryableState<DeliveryAddressActuator, DeliveryAddressPage> {
  _DeliveryAddressPageState(DeliveryAddressActuator actuator) : super(actuator);

  @override
  void initState() {
    super.initState();
    // actuator.init(UserAddress(name: "a", phone: "123"));
    actuator.check(fail: (LocationClient client, LFailType type) {
      if (client != null && type != null) {
        if (LFailType.ServiceUnusable == type) {
          /// 定位服务未开启
          showLocationPermissionAlert(S.of(context).alltip_gps_noopen);
        } else if (LFailType.Denied == type) {
          /// 定位权限未授予
          showLocationPermissionAlert(S.of(context).alltip_position_noopen);
        } else if (LFailType.DeniedForever == type) {
          /// 定位权限未授予被永久关闭【拒绝授权，且不让提示的那种】
          showLocationPermissionAlert(S.of(context).alltip_position_closeopen);
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var args = ModalRoute.of(context)!.settings.arguments;

    if (args != null && args is UserAddress) {
      actuator.init(args,context);
    }
  }

  void showLocationPermissionAlert(String message) {
    MessageDialog.show(context, message, tapRight: () {
      actuator.startLocation(fail: (LocationClient client, LFailType type) {
        if (client != null && type != null) {
          if (LFailType.ServiceUnusable == type) {
            client.openLocationSettings();
          } else if (LFailType.Denied == type) {
            // client.openSettings();
          } else if (LFailType.DeniedForever == type) {
            client.openSettings();
          }
        }
      });
    });
  }

  /**
   * 提交用户信息
   */
  void confirmUserInfo() {
    FocusScope.of(context).requestFocus(FocusNode());
    actuator.confirmUserInfo((UserAddress result) {
      Navigator.pop(context, result);
    }, start: () {
      LoadingDialog.show(context);
    }, end: () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        backgroundColor: AppColor.white,
        title: S.of(context).confirm_information,
      ),
      body: SingleChildScrollView(
          child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: EdgeInsets.all(16),
                alignment: Alignment.topLeft,
                child: buildBodyWidget(context),
              ),
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              })),
      bottomNavigationBar: buildConfirmButton(context),
    );
  }

  Widget buildBodyWidget(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(top: 24),
          alignment: Alignment.centerLeft,
          child: Text(
            S.of(context).confirm_billing_info,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          )),

      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 16),
          child: Text(
            S.of(context).confirm_fill_your_info,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          )),

      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 16),
          child: Text(
            S.of(context).confirm_name,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )),

      /// Name 输入框
      buildNameTextField(),

      /// 手机输入
      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 16),
          child: Text(
            S.of(context).confirm_phone_number,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )),

      /// Phone 输入框
      buildPhoneTextField(),

      /// 地址输入
      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 16),
          child: Text(
            S.of(context).confirm_address,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )),

      /// Address 输入框
      buildAddressTextField(),

      Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 32),
          child: Text(
            S.of(context).confirm_check_information,
            maxLines: 2,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          )),
    ]);
  }

  /**
   * Name 输入框
   */
  Container buildNameTextField() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 12),
      child: TextField(
        strutStyle: StrutStyle(),
        decoration: InputDecoration(
            counter: Container(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.color08000, width: 1)),
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            hintText: S.of(context).confirm_name,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 2,
        minLines: 1,
        maxLength: 32,
        textAlign: TextAlign.left,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppColor.colorF7551D,
        cursorWidth: 2,
        cursorRadius: Radius.circular(2),
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          actuator.name = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 name 是否为空
            text: '${this.actuator.name == null ? "" : this.actuator.name}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.name}'.length)))),
      ),
    );
  }

  /**
   * Phone 输入框
   */
  Container buildPhoneTextField() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 12),
      child: TextField(
        strutStyle: StrutStyle(),
        decoration: InputDecoration(
            counter: Container(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.color08000, width: 1)),
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            hintText: S.of(context).reminder_enterphone,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 1,
        minLines: 1,
        maxLength: 14,
        keyboardType: TextInputType.number,
        cursorColor: AppColor.colorF7551D,
        cursorWidth: 2,
        cursorRadius: Radius.circular(2),
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          actuator.phone = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 phone 是否为空
            text: '${this.actuator.phone == null ? "" : this.actuator.phone}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.phone}'.length)))),
      ),
    );
  }

  /**
   * Address 输入框
   */
  Container buildAddressTextField() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 12),
      child: TextField(
        strutStyle: StrutStyle(),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
            counter: Container(),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColor.color08000, width: 1)),
            contentPadding:
                EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            hintText: S.of(context).confirm_address,
            hintStyle: TextStyle(
              fontSize: 14,
              color: AppColor.hint,
            )),
        maxLines: 5,
        maxLength: 100,
        cursorColor: AppColor.colorF7551D,
        cursorWidth: 2,
        cursorRadius: Radius.circular(2),
        textAlign: TextAlign.left,
        style: TextStyle(color: AppColor.black, fontSize: 16),
        onChanged: (text) {
          actuator.address = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 phone 是否为空
            text:
                '${this.actuator.address == null ? "" : this.actuator.address}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.address}'.length)))),
      ),
    );
  }

  /**
   * 提交按钮
   */
  Widget buildConfirmButton(BuildContext context) {
    return Container(
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
                color: AppColor.bg,
                offset: Offset(2.0, 2.0),
                blurRadius: 5.0,
                spreadRadius: 0.6),
            BoxShadow(color: AppColor.bg, offset: Offset(1.0, 1.0)),
            BoxShadow(color: AppColor.bg)
          ],
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
              height: 44,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(44),
                  gradient: LinearGradient(
                      colors: [Color(0xFFFF8913), Color(0xFFFF0080)],
                      begin: FractionalOffset(1, 0),
                      end: FractionalOffset(0, 1))),
              child: Text(
                S.of(context).button_confirm,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              )),
          onTap: () {
            confirmUserInfo();
          },
        ));
  }
}
