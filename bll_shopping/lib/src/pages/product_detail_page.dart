import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:shopping/src/actuator/product_detail_actuator.dart';
import 'package:shopping/src/controller/shopping_cart_controller.dart';
import 'package:shopping/src/widget/cart/shopping_cart_bar.dart';

/**
 * product_detail_page.dart
 * 商品详情
 * @author: Ruoyegz
 * @date: 2021/7/1
 */
class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  _ProductDetailPageState createState() =>
      _ProductDetailPageState(ProductDetailActuator());
}

class _ProductDetailPageState
    extends RetryableState<ProductDetailActuator, ProductDetailPage> {
  bool isShoppingCartChanged = false;

  final ShoppingCartBarController barController =
      new ShoppingCartBarController();

  _ProductDetailPageState(ProductDetailActuator actuator) : super(actuator);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var id = ModalRoute.of(context)!.settings.arguments;
    actuator.productId = id as String;
    actuator.loadProductDetail();
  }

  @override
  void dispose() {
    if (isShoppingCartChanged &&
        actuator.product != null &&
        actuator.product.shop != null) {
      BusClient().fire(ShoppingCartUpdateEvent(actuator.product.shop!.id));
    }
    super.dispose();
  }

  /**
   * 添加购物车操作
   */
  void appendShopCart() {
    isShoppingCartChanged = true;
    var product = actuator.product;
    if (product != null && product.shop != null) {
      barController.outsideAddProduct(product, product.shop!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      CustomScrollView(
        slivers: [buildSliverAppBar(context), buildProductInfo()],
      ),
      buildShoppingCartBar()
    ]));
  }

  Widget buildShoppingCartBar() {
    if (actuator.product == null || actuator.product.shop == null) {
      return Container();
    }

    var showBar = UserManager().delivery(actuator.product.shop);
    return ShoppingCartBar(
        controller: barController,
        isShowBar: showBar,
        isCartProducts: showBar,
        shopId: "${actuator.product.shop!.id}");
  }

  Widget buildProductInfo() {
    if (actuator.product == null) {
      return SliverPadding(padding: EdgeInsets.all(0));
    }
    return SliverList(
      delegate: SliverChildBuilderDelegate((content, index) {
        return GestureDetector(
          child: Column(
            children: [
              /// 商品标题
              buildProductTitleAndAdd(),

              /// 商品评分
              buildProductStar(),

              Container(
                child: Text(
                  TextHelper.clean(actuator.product.formatPrice),
                  style: TextStyle(
                    color: AppColor.colorBE,
                    fontSize: 24,
                  ),
                ),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 16, right: 16, top: 10),
              ),

              Container(
                margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                color: AppColor.color08000,
                height: 1,
              ),

              Container(
                margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  S.of(context).product_description,
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  TextHelper.clean(actuator.product.description),
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
          onTap: () {
            barController.closeShopCart();
          },
        );
      }, childCount: 1),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    double expandedHeight = MediaQuery.of(context).size.width * 6 / 7;
    return SliverAppBar(
      pinned: true,
      elevation: 0.38,
      title: Text(
        "",
        style: TextStyle(color: AppColor.black, fontSize: 19),
      ),
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Image.asset(
            "res/icons/ic_back_dark.png",
            package: "resources",
          ),
        ),
        onTap: () => Navigator.pop(context),
      ),
      centerTitle: true,
      expandedHeight: expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
                topRight: Radius.circular(0)),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: CachedNetworkImage(
                fadeInDuration: const Duration(milliseconds: 100),
                imageUrl: actuator.product.productImage(),
                placeholder: (context, url) => Image.asset(
                  "res/images/def_cover_1_1.png",
                  package: 'resources',
                  height: expandedHeight,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  "res/images/def_cover_1_1.png",
                  package: 'resources',
                  height: expandedHeight,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  gaplessPlayback: true,
                ),
                height: 150,
                width: MediaQuery.of(context).size.width / 2,
                fit: BoxFit.cover,
              ),
              onTap: () {
                barController.closeShopCart();
              },
            )),
      ),
    );
  }

  Widget buildProductTitleAndAdd() {
    return Row(
      children: [
        Expanded(
            child: Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 14, left: 16, right: 16),
          child: Text(
            TextHelper.clean(actuator.product.name),
            textAlign: TextAlign.left,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: AppColor.black,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        )),
        buildAddShoppingCart()
      ],
    );
  }

  /**
   * 添加购物车
   */
  Widget buildAddShoppingCart() {
    if (actuator.product == null ||
        actuator.product.shop == null ||
        !UserManager().delivery(actuator.product.shop)) {
      return Container();
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        child: Image.asset(
          "res/icons/ic_option_add_big.png",
          package: "resources",
          width: 44,
          height: 44,
        ),
        margin: EdgeInsets.only(right: 16, top: 14),
      ),
      onTap: () {
        appendShopCart();
      },
    );
  }

  /**
   * 购物车商品图片
   */
  Widget buildProductImages(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.assetNetwork(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
          fadeInDuration: const Duration(milliseconds: 100),
          placeholder: "packages/resources/res/images/def_cover_1_1.png",
          image: actuator.product.productImage(),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset(
              "res/images/def_cover_1_1.png",
              package: "resources",
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
            );
          },
        ),
      ),
    );
  }

  /**
   * 商品的星级
   */
  Widget buildProductStar() {
    int star = actuator.product.averagePoint.toInt();
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      stars.add(buildSopStar(star >= i));
    }

    /// TODO: 暂无商品评论，先换成评分
    stars.add(Container(
      child: Text("(${actuator.product.averagePoint})"),
    ));

    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 10, left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: stars,
      ),
    );
  }

  Widget buildSopStar(bool isLight) {
    if (isLight) {
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 1),
          child: Image.asset(
            "res/icons/ic_star_light.png",
            package: "resources",
            width: 12,
            height: 12,
          ));
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        alignment: Alignment.center,
        child: Image.asset(
          "res/icons/ic_star_dark.png",
          package: "resources",
          width: 12,
          height: 12,
        ),
      );
    }
  }
}
