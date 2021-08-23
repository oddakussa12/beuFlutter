import 'package:address/src/actuator/address_book_actuator.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

/**
 * 地址薄
 */
class AddressBookPage extends StatefulWidget {
  const AddressBookPage({Key? key}) : super(key: key);

  @override
  _AddressBookPageState createState() =>
      _AddressBookPageState(AddressBookActuator());
}

class _AddressBookPageState
    extends RefreshableState<AddressBookActuator, AddressBookPage> {
  _AddressBookPageState(AddressBookActuator actuator) : super(actuator);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
