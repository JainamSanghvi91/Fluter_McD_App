import 'package:flutter/cupertino.dart';

class Items with ChangeNotifier {
  final int itemId;
  final String itemName;
  bool is_veg;
  final int price;
  final int categoryid;
  final List<Items> combo;

  Items({
    @required this.itemName,
    @required this.itemId,
    @required this.price,
    @required this.categoryid,
    this.is_veg,
    this.combo,
  });
}
