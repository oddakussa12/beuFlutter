import 'package:centre/centre.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/**
 * item_shop_grid.dart
 * 商铺 item
 * @author: Ruoyegz
 * @date: 2021/7/21
 */
class ItemShopGridStatelessWidget extends StatelessWidget {
  final Shop shop;

  const ItemShopGridStatelessWidget({Key? key, required this.shop})
      : super(key: key);

  iconFlame(int? num) {
    if ((num ?? 0) > 0) {
      return Image.asset(
        "res/icons/ic_flame_icon.png",
        package: "resources",
        width: 15,
        height: 15,
        color: Colors.transparent,
      );
    } else if ((num ?? 0) > 0) {
      return Image.asset(
        "res/icons/ic_flame_icon.png",
        package: "resources",
        width: 15,
        height: 15,
        color: Colors.transparent,
      );
    }
  }

  String distance(double? distance_value) {
    if ((distance_value ?? 0) == 0) return "- m";
    if ((distance_value ?? 0) >= 1)
      return (double.parse(((distance_value ?? 0)).toStringAsFixed(1))
              .toString()) +
          " km";
    else if ((distance_value ?? 0) < 1) {
      return (double.parse(((distance_value ?? 0) * 1000).toStringAsFixed(0))
              .toInt()
              .toString()) +
          " m";
    }

    return "";
  }

  String delivery_time(double? time) {
    // if ((time ?? 0) > 60) {
    //   return (double.parse(((time ?? 0) / 60).toStringAsFixed(0)).toInt().toString()) +
    //       " hours";
    // } else if ((time ?? 0) <= 60) {
    //   return (double.parse(((time ?? 0)).toStringAsFixed(0)).toInt().toString()) +
    //       " min";
    // }

    return ((time ?? 0) == 0
            ? "-"
            : double.parse(((time ?? 0)).toStringAsFixed(0))
                .toInt()
                .toString()) +
        " mins";
  }

  @override
  Widget build(BuildContext context) {
    LogDog.d("ItemShopGrid-shop: ${shop.id}");

    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              /// 商铺背景
              buildShopBackgroundByCache(shop, context),

              /// 派送图标
              //buildDeliveryIcon(shop.mayDelivery()),

              /// 商铺头像
              buildShopAvatarByCache(shop)
            ],
          ),

          /// 商铺标题
          Container(
            //  margin: EdgeInsets.only(top: 1),
            child: Text(
              TextHelper.clean(shop.nickName),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColor.h1,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),

          /// 商铺评分
          //  buildShopStars(shop),

          /// 商铺地址
          // Container(
          //   alignment: Alignment.center,
          //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          //   child: Text(
          //     TextHelper.clean(shop.address),
          //     textAlign: TextAlign.center,
          //     maxLines: PlatformSupport.ios() ? 2 : 1,
          //     overflow: TextOverflow.ellipsis,
          //     style: TextStyle(color: AppColor.color80000, fontSize: 12),
          //   ),
          // ),

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  child: Consumer<SettingsModel>(
                    builder: (context, settings, child) {
                      Row iconResource = Row(children: [
                        Image.asset("res/icons/ic_flame_icon.png",
                            package: "resources",
                            width: 15,
                            height: 15,
                            color: Colors.transparent)
                      ]);
                      if (shop.orderCount != null) {
                        if (shop.orderCount! >=
                            settings.getViewSettings().unpopularRestaurant) {
                          iconResource = Row(children: [
                            Image.asset(
                              "res/icons/ic_flame_icon.png",
                              package: "resources",
                              width: 15,
                              height: 15,
                            )
                          ]);
                        }
                        if (shop.orderCount! >=
                            settings.getViewSettings().popularRestaurant) {
                          iconResource = Row(
                            children: [
                              Image.asset(
                                "res/icons/ic_flame_icon.png",
                                package: "resources",
                                width: 15,
                                height: 15,
                              ),
                              Image.asset(
                                "res/icons/ic_flame_icon.png",
                                package: "resources",
                                width: 15,
                                height: 15,
                              )
                            ],
                          );
                        }
                        if (shop.orderCount! >=
                            settings.getViewSettings().superPopularRestaurant) {
                          iconResource = Row(
                            children: [
                              Image.asset(
                                "res/icons/ic_flame_icon.png",
                                package: "resources",
                                width: 15,
                                height: 15,
                              ),
                              Image.asset(
                                "res/icons/ic_flame_icon.png",
                                package: "resources",
                                width: 15,
                                height: 15,
                              ),
                              Image.asset(
                                "res/icons/ic_flame_icon.png",
                                package: "resources",
                                width: 15,
                                height: 15,
                              )
                            ],
                          );
                        }
                        if (shop.orderCount! >
                            settings.getViewSettings().blackHouseRestaurant) {
                          iconResource = Row(children: [
                            Image.asset("res/icons/ic_flame_icon.png",
                                package: "resources",
                                width: 15,
                                height: 15,
                                color: Colors.black)
                          ]);
                        }
                      }

                      return iconResource;
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    TextHelper.clean(
                        "${(shop.orderCount ?? 0) == 0 ? "-" : shop.orderCount ?? 0} " +
                            S.of(context).number_of_orders_in_amharic),
                    textAlign: TextAlign.center,
                    maxLines: PlatformSupport.ios() ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.yellow[900], fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  child: Image.asset(
                    "res/icons/ic_shop_delivery.png",
                    package: "resources",
                    width: 15,
                    height: 15,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      TextHelper.clean(
                          delivery_time(((shop.deliveryTime ?? 0) / 60))),
                      textAlign: TextAlign.center,
                      maxLines: PlatformSupport.ios() ? 2 : 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.yellow[900], fontSize: 15),
                    ),
                  ),
                ),
                Text(
                  " | ",
                  style: TextStyle(color: Colors.yellow[900], fontSize: 12),
                ),
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        TextHelper.clean(
                            distance(((shop.distance ?? 0) / 1000))),
                        textAlign: TextAlign.center,
                        maxLines: PlatformSupport.ios() ? 2 : 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            TextStyle(color: Colors.yellow[900], fontSize: 15),
                      )),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              // padding: EdgeInsets.only(top: 15),
              alignment: Alignment.center,
              //   margin: EdgeInsets.symmetric(horizontal: 5),

              child: Text(
                TextHelper.clean(
                    "${(shop.averagePrice ?? 0) == 0 ? "- " : (double.parse(((shop.averagePrice ?? 0)).toStringAsFixed(0)).toInt().toString())} " +
                        S.of(context).average_price_in_amharic),
                textAlign: TextAlign.center,
                maxLines: PlatformSupport.ios() ? 2 : 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDeliveryIcon(bool ableDelivery) {
    if (ableDelivery) {
      return Container(
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 8, right: 8),
        child: Image.asset(
          "res/icons/ic_shop_delivery.png",
          package: 'resources',
          width: 16,
          height: 16,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildShopBackgroundByCache(Shop shop, BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            imageUrl: TextHelper.clean(shop.bg),
            placeholder: (context, url) => Image.asset(
                "res/images/def_shop_image.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 100,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_shop_image.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 100,
                gaplessPlayback: true,
                width: MediaQuery.of(context).size.width),
            height: 100,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ));
  }

  /**
   * 构建商铺背景
   */
  Container buildShopBackground(Shop shop, BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: FadeInImage.assetNetwork(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            placeholder: "packages/resources/res/images/def_cover_8_5.png",
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset("res/images/def_cover_8_5.png",
                  package: 'resources',
                  fit: BoxFit.cover,
                  height: 100,
                  gaplessPlayback: true,
                  width: MediaQuery.of(context).size.width);
            },
            image: TextHelper.clean(shop.bg),
            height: 100,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ));
  }

  /**
   * 构建商铺头像
   */
  Widget buildShopAvatarByCache(Shop shop) {
    return Container(
      margin: EdgeInsets.only(top: 68),
      alignment: Alignment.topCenter,
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
            color: AppColor.colorEF,
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(42)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(64),
          child: CachedNetworkImage(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            imageUrl: TextHelper.clean(shop.avatarLink),
            placeholder: (context, url) => Image.asset(
                "res/images/def_avatar.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 64,
                gaplessPlayback: true,
                width: 64),
            errorWidget: (context, url, error) => Image.asset(
                "res/images/def_avatar.png",
                package: 'resources',
                fit: BoxFit.cover,
                height: 64,
                width: 64,
                gaplessPlayback: true),
            height: 64,
            width: 64,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  /**
   * 构建商铺头像
   */
  Container buildShopAvatar(Shop shop) {
    return Container(
      margin: EdgeInsets.only(top: 68),
      alignment: Alignment.topCenter,
      child: Container(
        height: 64,
        width: 64,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(42)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(64),
          child: FadeInImage.assetNetwork(
            fadeInDuration: const Duration(milliseconds: 50),
            fadeOutDuration: const Duration(milliseconds: 50),
            placeholder: "packages/resources/res/images/def_avatar.png",
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset("res/images/def_avatar.png",
                  package: 'resources');
            },
            image: TextHelper.clean(shop.avatarLink),
            height: 64,
            width: 64,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }

  /**
   * 商铺评分
   */
  Widget buildShopStars(Shop shop) {
    List<Widget> stars = [];
    int star = shop.getShopStar();

    for (int i = 1; i <= 5; i++) {
      stars.add(buildStar(star >= i));
    }
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: stars,
      ),
    );
  }

  Widget buildStar(bool isLight) {
    if (isLight) {
      return Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 1),
          child: Image.asset(
            "res/icons/ic_star_light.png",
            package: 'resources',
            width: 10,
            height: 10,
          ));
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 1),
        alignment: Alignment.center,
        child: Image.asset(
          "res/icons/ic_star_dark.png",
          package: 'resources',
          width: 10,
          height: 10,
        ),
      );
    }
  }
}
