import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * item_shop_grid.dart
 * 关注的商铺 item
 * @author: Ruoyegz
 * @date: 2021/7/21
 */
class ItemFollowShopWidget extends StatelessWidget {
  final Shop shop;

  const ItemFollowShopWidget({Key? key, required this.shop})
      : super(key: key);

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
              buildDeliveryIcon(shop.mayDelivery()),

              /// 商铺头像
              buildShopAvatarByCache(shop)
            ],
          ),

          /// 商铺标题
          Container(
            margin: EdgeInsets.only(top: 5),
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
          buildShopStars(shop),

          /// 商铺地址
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: Text(
              TextHelper.clean(shop.address),
              textAlign: TextAlign.center,
              maxLines: PlatformSupport.ios() ? 2 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: AppColor.color80000, fontSize: 12),
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

  Container buildShopBackgroundByCache(Shop shop, BuildContext context) {
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
            //placeholder: "packages/resources/res/images/def_cover_8_5.png",
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
  Container buildShopAvatarByCache(Shop shop) {
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
            fit: BoxFit.fitWidth,
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
