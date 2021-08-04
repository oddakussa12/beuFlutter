
class UserAddress {
  String? name;
  String? phone;
  String? address;

  List<String>? shopIds;

  /// 加密后的配送费
  String? deliveryCost;

  UserAddress(
      {this.name, this.phone, this.address, this.shopIds, this.deliveryCost});
}
