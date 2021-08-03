import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * delivery_address_page.dart
 * 编辑派送地址
 *
 * @author: Ruoyegz
 * @date: 2021/7/3
 */
class DeliveryAddressPage extends StatefulWidget {
  /**
   * 用户派送信息
   */
  final String? name;
  final String? phone;
  final String? address;

  const DeliveryAddressPage(
      {Key? key, this.name = "", this.phone = "", this.address = ""})
      : super(key: key);

  @override
  _DeliveryAddressPageState createState() =>
      _DeliveryAddressPageState(name, phone, address);
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  /**
   * 用户派送信息
   */
  String? name;
  String? phone;
  String? address;

  _DeliveryAddressPageState(this.name, this.phone, this.address);

  /**
   * 提交用户信息
   */
  void confirmUserInfo() {
    if (TextHelper.isEmpty(name!) || name!.length < 2 || name!.length > 32) {
      toast(message: S.of(context).confirm_name_rule);
      return;
    }

    if (TextHelper.isEmpty(phone!) || phone!.length < 7 || phone!.length > 14) {
      toast(message: S.of(context).confirm_phone_rule);
      return;
    }

    if (TextHelper.isEmpty(address!) ||
        address!.length < 10 ||
        address!.length > 100) {
      toast(message: S.of(context).confirm_address_rule);
      return;
    }

    List<String> result = [name!, phone!, address!];
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    if (Constants.isTesting) {
      name = "XMT-beU";
      phone = "1314520999";
      address = "太阳系地球村中国北京市";
    }
    return Scaffold(
      appBar: Toolbar(
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

      /// 提交按钮
      buildConfirm(context),
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
          name = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 name 是否为空
            text: '${this.name == null ? "" : this.name}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.name}'.length)))),
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
          phone = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 phone 是否为空
            text: '${this.phone == null ? "" : this.phone}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.phone}'.length)))),
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
          address = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 phone 是否为空
            text: '${this.address == null ? "" : this.address}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.address}'.length)))),
      ),
    );
  }

  /**
   * 提交按钮
   */
  Widget buildConfirm(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 44,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 60, bottom: 20),
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
    );
  }
}
