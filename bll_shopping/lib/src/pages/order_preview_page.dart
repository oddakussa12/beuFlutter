import 'package:common/common.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:shopping/src/actuator/delivery_address_actuator.dart';
import 'package:shopping/src/actuator/order_preview_actuator.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';
import 'package:shopping/src/entity/user_address.dart';
import 'package:shopping/src/items/item_order_preview.dart';
import 'package:shopping/src/items/item_order_price.dart';
import 'package:shopping/src/pages/delivery_address_page.dart';

/**
 * OrderPreviewPage
 * 订单预览
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class OrderPreviewPage extends StatefulWidget {
  const OrderPreviewPage({Key? key}) : super(key: key);

  @override
  _OrderPreviewPageState createState() =>
      _OrderPreviewPageState(OrderPreviewActuator());
}

class _OrderPreviewPageState
    extends RetryableState<OrderPreviewActuator, OrderPreviewPage>
    with ProductOptionProvider, AutomaticKeepAliveClientMixin {
  _OrderPreviewPageState(OrderPreviewActuator actuator) : super(actuator);

  var args;

  DeliveryAddressActuator userInfo = new DeliveryAddressActuator();
  @override
  bool get wantKeepAlive => true;
  late UserAddress userAddress;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (args == null) {
      args = ModalRoute.of(context)!.settings.arguments;
      if (args != null && args is Map<String, dynamic>) {
        if (args.containsKey("type")) {
          actuator.type = args["type"];
        }
        if (args.containsKey("goods")) {
          actuator.idNumbers = args["goods"];
        } else {
          actuator.idNumbers = args as Map<String, String>;
        }
        actuator.loadPreviewOrder();
      }
    }
    actuator.prepareDeliveryAddress((result) {
      var args = result;

      if (args != null && args is UserAddress) {
        FocusScope.of(context).requestFocus(FocusNode());
        actuator.deliveryINfo.init(args, context);
      }
    });
  }

  /**
   * 打开编辑地址页
   */
  void openDeliveryAddressPage(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    actuator.prepareDeliveryAddress((result) {
      Navigator.pushNamed(context, Routes.shopping.DeliveryAddress,
              arguments: result)
          .then((value) => processAddressResult(value));
    });
  }

  /**
   * 处理返回的地址信息
   */
  void processAddressResult(dynamic value) {
    LogDog.w("processAddressResult, value: ${value}");

    if (value != null) {
      UserAddress result = value as UserAddress;
      actuator.updateDeliveryAddress(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    LogDog.w("OrderPreviewPage, build");

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: Toolbar(
          title: S.of(context).order_details,
        ),
        preferredSize: Size.fromHeight(48),
      ),
      body: SingleChildScrollView(
        child: actuator.isNotNormal()
            ? buildEmptyWidget(context)
            : buildPreviewOrders(),
      ),
    );
  }

  /**
   * 购物车商品列表
   */
  Widget buildPreviewOrders() {
    return Container(
      child: Column(
        children: [
          buildOrderList(),

          /// 分割线
          actuator.isShowPromo()
              ? Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  color: AppColor.color08000,
                )
              : Container(),

          /// Promo code【优惠码】
          buildPromoCodeLayout(),

          /// Promo code【优惠码说明】
          buildPromoCodeMessage(),

          /// 分割线
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            color: AppColor.color08000,
          ),

          /// 派送用户信息地址
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Text(
              S.of(context).your_information,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 地址信息
          buildDeliveryUserInfo(),

          /// 派送用户地址Delivery address
          // Container(
          //   alignment: Alignment.centerLeft,
          //   margin: EdgeInsets.only(left: 16, right: 16, top: 32),
          //   child: Text(
          //     S.of(context).order_delivery_address,
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(
          //         color: AppColor.black,
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold),
          //   ),
          // ),

          /// 地址定位
          // buildDeliveryAddress(),

          /// 支付方式
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Text(
              S.of(context).order_payment_method,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 支付方式
          buildPaymentMethod(),

          /// 分割线
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 16, right: 16, top: 20),
            color: AppColor.color08000,
          ),

          /// 所有订单总价信息【Order Summary】
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Text(
              S.of(context).order_summary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 各订单总价
          buildOrderPriceList(),

          /// 订单包装费总价
          // buildOrdersPackageTotal(),

          /// 派送费
          //buildOrdersDeliveryTotal(),

          /// 折扣费
          // buildOrdersDiscountTotal(),

          /// 预览订单总价
          buildOrdersTotal(),

          /// 分割线
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 30),
            color: AppColor.color08000,
          ),

          /// 下单按钮
          buildCheckout()
        ],
      ),
    );
  }

  /// 订单列表
  ListView buildOrderList() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 8),
        shrinkWrap: true,
        itemCount: actuator.orderItems.length,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var orderNumber = index + 1;
          var orderItem = actuator.orderItems[index];
          return ItemOrderPreviewWidget(
            key: Key("${orderItem.shop!.id}-${DateTime.now().microsecond}"),
            orderNumber: orderNumber,
            shop: orderItem.shop!,
            provider: this,
            orderItem: orderItem,
          );
        });
  }

  /// 优惠码布局
  Widget buildPromoCodeLayout() {
    return actuator.isShowPromo()
        ? Stack(
            children: [
              buildPromoCodeField(context),

              /// 应用按钮
              Positioned(child: buildApplyButton(), right: 16, top: 16),
            ],
          )
        : Container();
  }

  /// Promo code 输入框
  Widget buildPromoCodeField(BuildContext context) {
    return Container(
        height: 44,
        padding: EdgeInsets.only(right: 76),
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
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
              hintText: S.of(context).changeproduct_promocode,
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColor.hint,
              )),
          maxLines: 1,
          maxLength: 100,
          keyboardType: TextInputType.text,
          cursorColor: AppColor.colorF7551D,
          cursorWidth: 2,
          cursorRadius: Radius.circular(2),
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.black, fontSize: 16),

          /// 只支持英文字母和数字
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9A-Za-z]'))
          ],
          onChanged: (text) {
            if (!TextHelper.isEqual(actuator.promoCode, text)) {
              actuator.promoCode = text;
            }
          },
          controller: TextEditingController.fromValue(TextEditingValue(
              //判断 name 是否为空
              text:
                  '${this.actuator.promoCode == null ? "" : this.actuator.promoCode}',
              // 保持光标在最后

              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset: '${this.actuator.promoCode}'.length)))),
        ));
  }

  /// Promo code apply
  Widget buildApplyButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 44,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColor.black, borderRadius: BorderRadius.circular(8)),
        child: Text(
          S.of(context).discover_filter_apply,
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColor.white, fontSize: 14),
        ),
      ),
      onTap: () {
        actuator.preparePromoCode();
      },
    );
  }

  /// 优惠码提示消息
  Widget buildPromoCodeMessage() {
    return actuator.isShowPromo() && actuator.showPromoMessage()
        ? Container(
            height: 40,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            decoration: actuator.orderP.code == 200
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFFB57A30),
                          Color(0xFFB57A30),
                          Color(0xFF973F0E)
                        ],
                        begin: FractionalOffset(1, 0),
                        end: FractionalOffset(0, 1)))
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.colorFF2222),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Offstage(
                  offstage: actuator.orderP.code == 200,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Image.asset(
                      "res/icons/ic_err_alert.png",
                      package: "resources",
                      width: 18,
                      height: 18,
                    ),
                  ),
                ),
                Text(
                  actuator.orderP.code == 200
                      ? actuator.orderP.message ?? ""
                      : S.of(context).alltip_promonotues,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColor.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        : Container();
  }

  /**
   * 地址信息
   */
  Widget buildDeliveryUserInfo() {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          margin: EdgeInsets.all(16),
          alignment: Alignment.topLeft,
          child: buildBodyWidget(context),
        ),
        onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        });

    //  Container(
    //     margin: EdgeInsets.only(left: 16, right: 16, top: 16),
    //     child: GestureDetector(
    //       behavior: HitTestBehavior.opaque,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         children: [
    //           /// 地址头像
    //           buildAddressUserAvatar(),

    //           /// 地址用户
    //           Expanded(
    //               child: Container(
    //             height: 48,
    //             alignment: Alignment.centerLeft,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.stretch,
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 /// 用户名
    //                 buildUserName(),

    //                 /// 联系方式
    //                 buildUserPhone()
    //               ],
    //             ),
    //           )),
    //           Icon(
    //             Icons.keyboard_arrow_right,
    //             color: AppColor.color99,
    //           ),
    //         ],
    //       ),
    //       onTap: () {
    //         openDeliveryAddressPage(context);
    //       },
    //     ));
  }

  /**
   * 地址头像
   */

  Widget buildBodyWidget(BuildContext context) {
    return Column(children: [
      // Container(
      //     margin: EdgeInsets.only(top: 24),
      //     alignment: Alignment.centerLeft,
      //     child: Text(
      //       S.of(context).confirm_billing_info,
      //       maxLines: 1,
      //       textAlign: TextAlign.left,
      //       style: TextStyle(
      //           color: AppColor.black,
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold),
      //     )),

      // Container(
      //     alignment: Alignment.centerLeft,
      //     margin: EdgeInsets.only(top: 16),
      //     child: Text(
      //       S.of(context).confirm_fill_your_info,
      //       maxLines: 1,
      //       textAlign: TextAlign.left,
      //       style: TextStyle(
      //           color: AppColor.black,
      //           fontSize: 12,
      //           fontWeight: FontWeight.bold),
      //     )),

      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            top: 12,
          ),
          child: Text(
            S.of(context).confirm_name,
            maxLines: 1,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 14,
              //  fontWeight: FontWeight.bold
                ),
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
                fontSize: 14,
              //  fontWeight: FontWeight.bold
                ),
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
                fontSize: 14,
                //fontWeight: FontWeight.bold
                ),
          )),

      /// Address 输入框
      buildAddressTextField(),

  
    ]);
  }

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
        style: TextStyle(color: AppColor.black, fontSize: 14),
        onChanged: (text) {
          actuator.deliveryINfo.name = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 name 是否为空
            // text: 'name',
            text:
                '${this.actuator.deliveryINfo.name == null ? "" : this.actuator.deliveryINfo.name}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.deliveryINfo.name}'.length)))),
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
        style: TextStyle(color: AppColor.black, fontSize: 14),
        onChanged: (text) {
          actuator.deliveryINfo.phone = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 phone 是否为空

            text:
                '${actuator.deliveryINfo.phone == null ? "" : this.actuator.deliveryINfo.phone}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.deliveryINfo.phone}'.length)))),
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
        style: TextStyle(color: AppColor.black, fontSize: 14),
        onChanged: (text) {
          actuator.deliveryINfo.address = text;
        },
        controller: TextEditingController.fromValue(TextEditingValue(
            //判断 phone 是否为空

            text:
                '${this.actuator.deliveryINfo.address == null ? "" : this.actuator.deliveryINfo.address}',
            // 保持光标在最后

            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: '${this.actuator.deliveryINfo.address}'.length)))),
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
            // print(actuator.deliveryINfo.name);
            //confirmUserInfo();
          },
        ));
  }

  void confirmUserInfoMethod(BuildContext context) {
    //FocusScope.of(context).requestFocus(FocusNode());
    // print(actuator.deliveryINfo.name);

    confirmUserInfo(context, (UserAddress result) {
      processAddressResult(result);
    }, start: () {
      LoadingDialog.show(context);
    }, end: () {
      // Navigator.pop(context);
    });
  }

  Widget buildAddressUserAvatar() {
    var avatarUri =
        actuator.orderP.avatar ?? UserManager().getUser().avatarLink ?? "";
    return ClipRRect(
        borderRadius: BorderRadius.circular(44),
        child: CachedNetworkImage(
          fadeInDuration: const Duration(milliseconds: 50),
          fadeOutDuration: const Duration(milliseconds: 50),
          imageUrl: avatarUri,
          placeholder: (context, url) => Image.asset(
              "res/images/def_cover_1_1.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 44,
              gaplessPlayback: true,
              width: 44),
          errorWidget: (context, url, error) => Image.asset(
              "res/images/def_cover_1_1.png",
              package: 'resources',
              fit: BoxFit.cover,
              height: 44,
              gaplessPlayback: true,
              width: 44),
          height: 44,
          width: 44,
          fit: BoxFit.cover,
        ));
  }

  Container buildUserName() {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 2),
        alignment: Alignment.topLeft,
        child: Text(
          actuator.orderP.name == ""
              //? S.of(context).login_username // todo: ask explain Flutter developer
              ? (UserManager().getUser().nickName?.toString() ??
                  S.of(context).login_username)
              : TextHelper.clean(actuator.orderP.name),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppColor.color0F0F17, fontSize: 14),
        ));
  }

  Container buildUserPhone() {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16),
        alignment: Alignment.topLeft,
        child: Text(
          actuator.orderP.phone == ""
              // ? S.of(context).confirm_phone_number // todo: same as buildUserName
              ? (UserManager().getUser().phone?.toString() ??
                  S.of(context).confirm_phone_number)
              : TextHelper.clean(actuator.orderP.phone),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: AppColor.colorF7551D, fontSize: 14),
        ));
  }

  /**
   * 派送地址信息
   */
  Widget buildDeliveryAddress() {
    return Container(
        margin: EdgeInsets.only(left: 16, top: 16, right: 10),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// 定位图标
              Image.asset(
                "res/images/delivery_address.png",
                package: "resources",
                width: 44,
                height: 44,
              ),

              /// 定位信息
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        actuator.orderP.address == ""
                            ? S.of(context).confirm_address
                            : TextHelper.clean(actuator.orderP.address),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: AppColor.black, fontSize: 14),
                      ))),

              Icon(
                Icons.keyboard_arrow_right,
                color: AppColor.color99,
              ),
            ],
          ),
          onTap: () {
            openDeliveryAddressPage(context);
          },
        ));
  }

  /**
   * 支付方式
   */
  Widget buildPaymentMethod() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 支付图标
          Image.asset(
            "res/images/delivery_payment.png",
            package: "resources",
            width: 44,
            height: 44,
          ),

          /// 支付信息
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    S.of(context).order_cash,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppColor.colorBE, fontSize: 14),
                  ))),
        ],
      ),
    );
  }

  /**
   * 订单价格列表
   */
  ListView buildOrderPriceList() {
    return ListView.builder(
        padding: EdgeInsets.only(left: 16, right: 16),
        shrinkWrap: true,
        itemCount: actuator.orderItems.length,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var orderNumber = index + 1;
          var orderItem = actuator.orderItems[index];
          return ItemOrderPriceWidget(
            key: Key("${orderItem.shop!.id}-${DateTime.now().microsecond}"),
            orderNumber: orderNumber,
            orderItem: orderItem,
          );
        });
  }

  /**
   * 所有的订单包装费总价
   */
  Widget buildOrdersPackageTotal() {
    /// 不同币种不计算订单总价
    if (actuator.orderP.diffCurrency!) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 16, right: 16, top: 14),
      child: Row(
        children: [
          Text(
            S.of(context).changeproduct_packagefee,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(actuator.orderP.formatTotal),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ))
        ],
      ),
    );
  }

  /**
   * 所有的订单派送费总价
   */
  Widget buildOrdersDeliveryTotal() {
    /// 不同币种不计算订单总价
    if (actuator.orderP.diffCurrency!) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 16, right: 16, top: 14),
      child: Row(
        children: [
          Text(
            /// TODO:
            "Delivery Total",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(actuator.orderP.formatDeliveryTotal),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ))
        ],
      ),
    );
  }

  ///
  Widget buildOrdersDiscountTotal() {
    /// 不同币种不计算订单总价
    if (actuator.orderP.diffCurrency!) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 16, right: 16, top: 14),
      child: Row(
        children: [
          Text(
            /// TODO:
            "Discount",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorF7551D,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(actuator.orderP.formatDiscountTotal),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorF7551D,
              fontSize: 14,
            ),
          ))
        ],
      ),
    );
  }

  /**
   * 所有的订单总价
   */
  Widget buildOrdersTotal() {
    /// 不同币种不计算订单总价
    if (actuator.orderP.diffCurrency!) {
      return Container();
    }
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: 16, right: 16, top: 14),
      child: Row(
        children: [
          Text(
            S.of(context).order_total,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(actuator.orderP.formatTotal),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }

  /**
   * 下单按钮
   */
  Widget buildCheckout() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          height: 44,
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(44),
              gradient: LinearGradient(
                  colors: [Color(0xFFFF8913), Color(0xFFFF0080)],
                  begin: FractionalOffset(1, 0),
                  end: FractionalOffset(0, 1))),
          child: Text(
            S.of(context).order_checkout,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.white,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          )),
      onTap: () {
        confirmUserInfoMethod(context);
        prepareConfirmOrder();
      },
    );
  }

  /**
   * 提交预览的订单
   * action:
   * 1: 跳转地址编辑页
   * 2：加载进度条
   * 3：订单创建完成
   * 4：下单失败
   */
  void prepareConfirmOrder() {
    actuator.checkoutPreviewOrder((status) {
      if (status == 1) {
        toast(message: S.of(context).confirm_address_no);
        // openDeliveryAddressPage(context);
      } else if (status == 2) {
        LoadingDialog.show(context);
      } else if (status == 3) {
        /// 先关闭 Loading
        Navigator.pop(context);

        /// 在关闭当前页面
        Navigator.pop(context);
      } else if (status == 4) {
        /// 下单失败
        Navigator.pop(context);
      }
    });
  }

  void confirmUserInfo(BuildContext context, Success<UserAddress> success,
      {Complete? start, Complete? end}) {
    if (TextHelper.isEmpty(actuator.deliveryINfo.name!) ||
        actuator.deliveryINfo.name!.length < 2 ||
        actuator.deliveryINfo.name!.length > 32) {
      notifyToasty(S.of(context).confirm_name_rule);

      return;
    }

    if (TextHelper.isEmpty(actuator.deliveryINfo.phone!) ||
        actuator.deliveryINfo.phone!.length < 7 ||
        actuator.deliveryINfo.phone!.length > 14) {
      notifyToasty(S.of(context).confirm_phone_rule);
      return;
    }

    if (TextHelper.isEmpty(actuator.deliveryINfo.address!) ||
        actuator.deliveryINfo.address!.length < 10 ||
        actuator.deliveryINfo.address!.length > 100) {
      notifyToasty(S.of(context).confirm_address_rule);

      return;
    }
    print(actuator.deliveryINfo.name);
    success.call(UserAddress(
        name: actuator.deliveryINfo.name,
        phone: actuator.deliveryINfo.phone,
        address: actuator.deliveryINfo.address));
    // if (locAddress == null || shopIds == null || shopIds!.isEmpty) {
    //   success.call(UserAddress(name: name, phone: phone, address: address));
    // } else {
    //   if (start != null) {
    //     start.call();
    //   }
    //   calcDeliveryCoast(success, start: start, end: end);
    // }
  }
}
