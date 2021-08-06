
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class ItemOrderPriceWidget extends StatefulWidget {
  final int orderNumber;
  final PreOrder orderItem;

  const ItemOrderPriceWidget(
      {Key? key, required this.orderNumber, required this.orderItem})
      : super(key: key);

  @override
  _ItemOrderPriceWidgetState createState() =>
      _ItemOrderPriceWidgetState(orderNumber, orderItem);
}

class _ItemOrderPriceWidgetState extends State<ItemOrderPriceWidget> {
  final int orderNumber;
  final PreOrder orderItem;

  _ItemOrderPriceWidgetState(this.orderNumber, this.orderItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 14),
      child: Row(
        children: [
          Text(
            "${S.of(context).order_how_many(orderNumber)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ),
          Expanded(
              child: Text(
            TextHelper.clean(orderItem.formatTotal),
            maxLines: 1,
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: AppColor.colorBE,
              fontSize: 14,
            ),
          ))
        ],
      ),
    );
  }
}
