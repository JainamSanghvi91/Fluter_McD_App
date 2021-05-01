import 'package:flutter/cupertino.dart';

class Customer with ChangeNotifier {
  final String name;
  bool is_veg;
  final String phone;

  Customer({
    @required this.name,
    this.is_veg,
    @required this.phone,
  });
}
