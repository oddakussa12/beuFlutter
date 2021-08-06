import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/actuator/order_preview_actuator.dart';
import 'package:shopping/src/actuator/product_option_provider.dart';
import 'package:shopping/src/entity/user_address.dart';
import 'package:shopping/src/items/item_order_preview.dart';
import 'package:shopping/src/items/item_order_price.dart';

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
    with ProductOptionProvider {
  _OrderPreviewPageState(OrderPreviewActuator actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    String type = "";
    Map<String, String> productIdNumbers = {};
    var args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      if (args.containsKey("type")) {
        type = args["type"];
      }
      if (args.containsKey("goods")) {
        productIdNumbers = args["goods"];
      } else {
        productIdNumbers = args as Map<String, String>;
      }
    }

    actuator.loadPreviewOrder(type, productIdNumbers);
  }

  /**
   * 打开编辑地址页
   */
  void openDeliveryAddressPage(BuildContext context) {
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
    if (value != null && value is UserAddress) {
      UserAddress result = value as UserAddress;
      actuator.orderP.name = result.name;
      actuator.orderP.phone = result.phone;
      actuator.orderP.address = result.address;

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            color: AppColor.color08000,
          ),

          /// 派送用户信息地址
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Text(
              S.of(context).order_beneficiary,
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
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Text(
              S.of(context).order_delivery_address,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 地址定位
          buildDeliveryAddress(),

          /// 支付方式
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16, right: 16, top: 30),
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

          /// Promo code【优惠码】
          Stack(
            children: [
              buildPromoCodeField(context),

              /// 应用按钮
              Positioned(child: buildApplyButton(), right: 16, top: 16),
            ],
          ),

          /// Promo code【优惠码说明】
          Container(
            height: 40,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(colors: [
                  Color(0xFFB57A30),
                  Color(0xFFB57A30),
                  Color(0xFF973F0E)
                ], begin: FractionalOffset(1, 0), end: FractionalOffset(0, 1))),
            child: Text(
              "20% off for all products over BIRR 300",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),

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
            margin: EdgeInsets.only(left: 16, right: 16, top: 20),
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
          buildOrdersPackageTotal(),

          /// 派送费
          buildOrdersDeliveryTotal(),

          ///
          buildOrdersDiscountTotal(),

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

  ListView buildOrderList() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 8),
        shrinkWrap: true,
        itemCount: actuator.orderItems.length,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var orderNumber = index + 1;
          var orderItem = actuator.orderItems[index];
          return Container(
            child: ItemOrderPreviewWidget(
              key: Key("${orderItem.shop!.id}"),
              orderNumber: orderNumber,
              shop: orderItem.shop!,
              provider: this,
              orderItem: orderItem,
            ),
          );
        });
  }

  /**
   * 地址信息
   */
  Widget buildDeliveryUserInfo() {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// 地址头像
              buildAddressUserAvatar(),

              /// 地址用户
              Expanded(
                  child: Container(
                height: 44,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// 用户名
                    buildUserName(),

                    /// 联系方式
                    buildUserPhone()
                  ],
                ),
              )),
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
   * 地址头像
   */
  Widget buildAddressUserAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(44),
      child: FadeInImage.assetNetwork(
        height: 44,
        width: 44,
        fit: BoxFit.cover,
        fadeInDuration: const Duration(milliseconds: 100),
        placeholder: "packages/resources/res/images/def_cover_1_1.png",
        image: "${actuator.orderP.avatar}",
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "res/images/def_cover_1_1.png",
            package: "resources",
            height: 44,
            width: 44,
          );
        },
      ),
    );
  }

  Container buildUserName() {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 2),
        alignment: Alignment.topLeft,
        child: Text(
          actuator.orderP.name == ""
              ? S.of(context).login_username
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
              ? S.of(context).confirm_phone_number
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

  /// Promo code 输入框
  Widget buildPromoCodeField(BuildContext context) {
    return Expanded(
      child: Container(
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
                hintText: "Promo code",
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
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColor.black, fontSize: 16),
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
          )),
    );
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
        notifyToasty("别点，会崩的");
      },
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
          return Container(
            child: ItemOrderPriceWidget(
              key: Key("${orderItem.shop!.id}-${DateTime.now().microsecond}"),
              orderNumber: orderNumber,
              orderItem: orderItem,
            ),
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
            "Packaging Total",
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
        actuator.checkoutPreviewOrder(() {
          /// 向主页发送订单创建成功的通知
          BusClient().fire(OrderCreatedEvent());
          Navigator.pop(context);
        });
      },
    );
  }
}
