import 'package:common/common.dart';
import 'package:discover/src/actuator/product_actuator.dart';
import 'package:discover/src/items/item_product_grid.dart';
import 'package:discover/src/pages/special_discover_page.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/**
 * products_page.dart
 * 发现页-商品列表
 * @author: Ruoyegz
 * @date: 2021/6/29
 */
class ProductsPage extends StatefulWidget {
  RetrySpecialCallback? callback;

  ProductsPage({this.callback});

  @override
  State<ProductsPage> createState() =>
      new _ProductsPageState(ProductsActuator());
}

class _ProductsPageState
    extends RefreshableState<ProductsActuator, ProductsPage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  _ProductsPageState(ProductsActuator actuator) : super(actuator);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    actuator.callback = widget.callback;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.pullDown();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    LogDog.d("ProductsPage-build");

    return SmartRefresher(
        controller: refreshController,
        header: WaterDropHeader(),
        footer: ClassicFooter(),
        enablePullDown: false,
        enablePullUp: true,
        onRefresh: () {
          actuator.pullDown();
        },
        onLoading: () {
          actuator.pullUp();
        },
        child: actuator.isNotNormal()
            ? buildEmptyWidget(
                context,
                message: S.of(context).allpage_productnofind,
              )
            : buildProducts());
  }

  GridView buildProducts() {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.73,
        ),
        itemCount: actuator.products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = actuator.products[index];
          return GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            child: ItemProductGridWidget(
                key: Key("${product.id}-${product.name}"),
                product: product,
                showOptions: false),
            onTap: () => clickProduct(context, product),
          );
        });
  }

  void clickProduct(BuildContext context, Product product) {
    Navigator.pushNamed(context, Routes.shopping.ProductDetail,
        arguments: product.id);
  }
}
