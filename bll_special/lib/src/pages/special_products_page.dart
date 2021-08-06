import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:special/src/actuator/special_products_actuator.dart';
import 'package:special/src/items/item_special_product.dart';

/**
 * SpecialProductsPage
 * 特价商品列表
 * @author: Ruoyegz
 * @date: 2021/8/4
 */
class SpecialProductsPage extends StatefulWidget {
  const SpecialProductsPage({Key? key}) : super(key: key);

  @override
  _SpecialProductsPageState createState() =>
      _SpecialProductsPageState(SpecialProductsActuator());
}

class _SpecialProductsPageState
    extends RefreshableState<SpecialProductsActuator, SpecialProductsPage> {
  _SpecialProductsPageState(SpecialProductsActuator actuator) : super(actuator);

  static final double MAX_OFFSET = 40;

  ScrollController scrollController = ScrollController();

  double lastOffset = 0;
  Color barColor = AppColor.transparent;
  bool showTitle = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      double offset = scrollController.position.pixels;

      if (lastOffset > offset) {
        LogDog.w("scrollController, pos: ${offset}");
      } else {
        LogDog.w("scrollController, pos: ${offset}");
      }

      if (offset > MAX_OFFSET) {
        setState(() {
          showTitle = true;
          //barColor = AppColor.transparent;
        });
      } else {
        setState(() {
          showTitle = false;
          //barColor = AppColor.translucence;
        });
      }
      lastOffset = offset;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    actuator.pullDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorFF34,
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [buildSliverAppBar(context)],
        body: SmartRefresher(
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
                : buildProducts()),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: AppSizes.barSize,
      backgroundColor: barColor,
      leading: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.colorB3FFF,
            size: 20,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: Offstage(
        offstage: showTitle,
        child: Text(
          "Special Offers",
          style: TextStyle(color: AppColor.colorB3FFF, fontSize: 19),
        ),
      ),
      centerTitle: true,
      pinned: true,
      floating: true,
      elevation: 0,
    );
  }

  GridView buildProducts() {
    return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 16,
          childAspectRatio: 0.76,
        ),
        itemCount: actuator.products.length,
        itemBuilder: (BuildContext context, int index) {
          SpecProduct product = actuator.products[index];
          return GestureDetector(
            behavior: HitTestBehavior.deferToChild,
            child: ItemSpecialProductWidget(
                key: Key("${product.id}-${product.name}"),
                product: product,
                showOptions: false),
            // onTap: () => clickProduct(context, product),
          );
        });
  }

  void clickProduct(BuildContext context, Product product) {
    Navigator.pushNamed(context, Routes.shopping.ProductDetail,
        arguments: product.id);
  }
}
