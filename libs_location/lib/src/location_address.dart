/**
 * location_address.dart
 * 定位地址信息
 * @author: Ruoyegz
 * @date: 2021/8/3
 */
class LocationAddress {
  double longitude;
  double latitude;

  String? street;
  String? address;

  LocationAddress(this.longitude, this.latitude, {this.street, this.address});
}
