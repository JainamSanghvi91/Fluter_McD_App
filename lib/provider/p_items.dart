import 'package:McD/models/item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class P_Items with ChangeNotifier {
  List<Items> items = [];

  Future<void> fetchItems() async {
    final url = 'https://hackathon-2.herokuapp.com/api/items/';
    print("in fetch category");
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );
      final res = json.decode(response.body);
      print('res');
      print(res);
      final List<Items> loadedcategory = [];
      res.forEach((f) {
        loadedcategory.add(
          Items(
            itemId: f['id'],
            itemName: f['item_name'],
            is_veg: f['is_veg'],
            price: f['price'],
            categoryid: f['c_id'],
          ),
        );
      });
      print('loadedcategories');
      print(loadedcategory);
      items = loadedcategory;
      return items;
    } catch (error) {
      print("Error");
      print(error);
      throw (error);
    }
  }

  List<Items> findBycategoryId(int cid) {
    List<Items> itemslist =
        items.where((test) => test.categoryid == cid).toList();
    notifyListeners();
    return itemslist;
  }

  List<Items> findByvegfilter(int i) {
    List<Items> itemslist = [];
    i == 0
        ? itemslist = items.where((test) => test.is_veg == true).toList()
        : itemslist = items.where((test) => test.is_veg == false).toList();
    notifyListeners();
    return itemslist;
  }

  List<Items> findItemsByID(int id) {
    return items;
  }
}
