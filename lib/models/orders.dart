import 'package:flutter/cupertino.dart';

class Orders with ChangeNotifier {
  final int orderId;
  final String orderName;
  bool is_veg;
  final String name;
  final String phone;
  final int total;
  final String date;
  final List<Orders> meal;
  final List<Orders> items;

  Orders(
      {@required this.orderName,
      @required this.orderId,
      @required this.name,
      @required this.phone,
      @required this.total,
      @required this.date,
      this.is_veg,
      this.meal,
      this.items});
}
