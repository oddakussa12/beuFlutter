import 'package:entity/src/base_entity.dart';
import 'package:entity/src/shop_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_entity.g.dart';

/**
 * product.dart
 * 商品列表
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable(includeIfNull: true)
class ProductList {
  Links? links;
  Metadata? meta;

  List<Product> data;

  ProductList(this.links, this.meta, this.data);

  factory ProductList.fromJson(Map<String, dynamic> json) =>
      _$ProductListFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListToJson(this);
}

/**
 * product.dart
 * 商铺详情
 * @author: Ruoyegz
 * @date: 2021/7/5
 */
@JsonSerializable()
class ProductDetailBody {
  Product data;

  ProductDetailBody(this.data);

  factory ProductDetailBody.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailBodyToJson(this);
}

/**
 * product
 * 商品信息
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable()
class Product {
  String id;

  @JsonKey(name: "user_id")
  String userId;

  String name;
  String currency;
  String description;

  List<ImageEntity>? image;

  @JsonKey(name: "created_at")
  String createdAt;

  @JsonKey(name: "format_price")
  String formatPrice;

  double price;

  @JsonKey(name: "average_point")
  double averagePoint;

  int like;
  int status;

  /// 购物车：所选商品数量
  int? goodsNumber;

  bool? isChecked = false;

  @JsonKey(name: "user")
  Shop? shop;

  bool alreadyChecked() {
    return isChecked != null && isChecked!;
  }

  String productImage() {
    if (image != null && image!.isNotEmpty) {
      return image![0].url;
    }
    return "";
  }

  Product(
      {required this.id,
      required this.userId,
      required this.name,
      required this.currency,
      required this.description,
      required this.image,
      required this.createdAt,
      required this.formatPrice,
      required this.price,
      required this.averagePoint,
      required this.like,
      required this.status,
      this.shop,
      this.goodsNumber = 0,
      this.isChecked = false});

  factory Product.create() {
    return Product(
        id: "",
        userId: "",
        name: "",
        currency: "",
        description: "",
        image: [],
        createdAt: "",
        formatPrice: "",
        price: 0.0,
        averagePoint: 0.0,
        like: 0,
        status: 0);
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
