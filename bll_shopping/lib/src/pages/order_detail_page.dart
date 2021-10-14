import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/actuator/order_detail_actuator.dart';
import 'package:shopping/src/items/item_order_detail.dart';

/**
 * order_detail_page.dart
 * 订单详情
 *
 * @author: Ruoyegz
 * @date: 2021/7/2
 */
class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  _OrderDetailPageState createState() =>
      _OrderDetailPageState(OrderDetailActuator());
}

class _OrderDetailPageState
    extends RetryableState<OrderDetailActuator, OrderDetailPage> {
  _OrderDetailPageState(OrderDetailActuator actuator) : super(actuator);

  var orderId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (orderId == null) {
      orderId = ModalRoute.of(context)!.settings.arguments;
      actuator.orderId = orderId as String;
      actuator.loadOrderDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: Toolbar(title: S.of(context).order_details),
      body: SingleChildScrollView(
        child: actuator.isNotNormal()
            ? buildEmptyWidget(context)
            : Container(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 购物车商品列表
                  buildPreviewOrders(),
                ],
              )),
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

          buildPromoCode(),

          TextHelper.isNotEmpty(actuator.order.promoCode)
              ? Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                  color: AppColor.color08000,
                )
              : Container(),

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
        ],
      ),
    );
  }

  ListView buildOrderList() {
    return ListView.builder(
        padding: EdgeInsets.only(top: 8),
        shrinkWrap: true,
        itemCount: 1,
        physics: new NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            child: ItemOrderDetailWidget(
              key: Key(
                  "${actuator.order.id}-${DateTime.now().microsecondsSinceEpoch}"),
              shop: actuator.order.shop!,
              order: actuator.order,
            ),
          );
        });
  }

  /// 优惠码
  Widget buildPromoCode() {
    return TextHelper.isNotEmpty(actuator.order.promoCode)
        ? Container(
            height: 40,
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColor.colorEF),
            child: Text(
              actuator.order.promoCode,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.color99,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ))
        : Container();
  }

  /**
   * 地址信息
   */
  Widget buildDeliveryUserInfo() {
    return Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
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
          ],
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
        fadeInDuration: const Duration(milliseconds: 300),
        placeholder: "packages/resources/res/images/def_cover_1_1.png",

        /// TODO:
        image: TextHelper.clean(UserManager().getUser().avatarLink),
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
          "build user name", //TextHelper.clean(actuator.order.user),
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
          TextHelper.clean(actuator.order.contact),
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
        margin: EdgeInsets.only(left: 16, top: 16, right: 16),
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
                      TextHelper.clean(actuator.order.address),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColor.black, fontSize: 14),
                    ))),
          ],
        ));
  }

  /**
   * 支付方式
   */
  Widget buildPaymentMethod() {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 30),
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
          Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                S.of(context).order_cash,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColor.colorBE, fontSize: 14),
              )),
        ],
      ),
    );
  }
}
