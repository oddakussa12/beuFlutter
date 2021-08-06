import 'package:entity/src/base_entity.dart';
import 'package:entity/src/shop_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:origin/origin.dart';

part 'product_entity.g.dart';

/**
 * product.dart
 * 商品列表
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable()
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
  String? userId;

  String? name;
  String? currency;
  String? description;

  List<ImageEntity>? image;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "format_price")
  String? formatPrice;

  double? price;

  @JsonKey(name: "average_point")
  double? averagePoint;

  int? like;
  int? status;

  /// 购物车：所选商品数量
  int? goodsNumber;

  bool? isChecked = false;

  @JsonKey(name: "user")
  Shop? shop;

  /// 1.1.0: 数值版特价
  @JsonKey(name: "specialPrice")
  double? specPrice;

  /// 1.1.0: 包装费
  @JsonKey(name: "packaging_cost")
  double? packageCoast;

  /// 1.1.0: 折扣价格
  @JsonKey(name: "discounted_price")
  double? disPrice;

  /// 1.1.0: 格式化折扣价格
  @JsonKey(name: "format_discounted_price")
  String? formatDisPrice;

  /// 1.1.0: 格式化包装费
  @JsonKey(name: "format_packaging_cost")
  String? formatPackagePrice;

  /// 1.1.0: 免费配送
  bool? freeDelivery;

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
      this.userId,
      this.name,
      this.currency,
      this.description,
      this.image,
      this.createdAt,
      this.formatPrice,
      this.price,
      this.averagePoint,
      this.like,
      this.status,
      this.goodsNumber,
      this.shop,
      this.specPrice,
      this.packageCoast,
      this.disPrice,
      this.formatDisPrice,
      this.formatPackagePrice,
      this.freeDelivery});

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

/**
 * SpecProductList
 * 特价商品列表
 *
 * @author: Ruoyegz
 * @date: 2021/6/30
 */
@JsonSerializable()
class SpecProductList {
  Links? links;
  Metadata? meta;

  List<SpecProduct> data;

  SpecProductList(this.links, this.meta, this.data);

  factory SpecProductList.fromJson(Map<String, dynamic> json) =>
      _$SpecProductListFromJson(json);

  Map<String, dynamic> toJson() => _$SpecProductListToJson(this);
}

/**
 * product_entity.dart
 * 特价商品
 * @author: Ruoyegz
 * @date: 2021/8/5
 */
@JsonSerializable()
class SpecialProductBody {
  SpecialProduct data;

  SpecialProductBody(this.data);

  factory SpecialProductBody.fromJson(Map<String, dynamic> json) =>
      _$SpecialProductBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialProductBodyToJson(this);
}

/**
 * product_entity.dart
 * 特价商品
 * @author: Ruoyegz
 * @date: 2021/8/5
 */
@JsonSerializable()
class SpecialProduct {
  int count;
  String image;

  SpecialProduct(this.count, this.image);

  factory SpecialProduct.fromJson(Map<String, dynamic> json) =>
      _$SpecialProductFromJson(json);

  Map<String, dynamic> toJson() => _$SpecialProductToJson(this);
}

/**
 * product_entity.dart
 * 特价商品
 * @author: Ruoyegz
 * @date: 2021/8/5
 */
@JsonSerializable()
class SpecProduct {

  String id;

  @JsonKey(name: "user_id")
  String? userId;

  String? name;
  String? currency;
  String? description;

  List<ImageEntity>? image;

  @JsonKey(name: "created_at")
  String? createdAt;

  @JsonKey(name: "format_price")
  String? formatPrice;

  double? price;

  @JsonKey(name: "average_point")
  double? averagePoint;

  int? like;
  int? status;

  /// 购物车：所选商品数量
  int? goodsNumber;

  bool? isChecked = false;

  @JsonKey(name: "user")
  Shop? shop;

  /// 1.1.0: 特价
  String? specialPrice;


  SpecProduct(
      this.id,
      this.userId,
      this.name,
      this.currency,
      this.description,
      this.image,
      this.createdAt,
      this.formatPrice,
      this.price,
      this.averagePoint,
      this.like,
      this.status,
      this.goodsNumber,
      this.isChecked,
      this.shop,
      this.specialPrice);

  factory SpecProduct.fromJson(Map<String, dynamic> json) =>
      _$SpecProductFromJson(json);

  Map<String, dynamic> toJson() => _$SpecProductToJson(this);
}
