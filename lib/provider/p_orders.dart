import 'package:McD/models/item.dart';
import 'package:McD/models/orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class P_Orders with ChangeNotifier {
  List<Orders> items = [];

  Future<void> fetchOrders() async {
    final url = 'https://hackathon-2.herokuapp.com/api/order/';
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
      final List<Orders> loadedcategory = [];
      res.forEach((f) {
        loadedcategory.add(
          Orders(
            orderId: f['id'],
            orderName: f['item_name'],
            name: f['c_name'],
            phone: f['phone'],
            is_veg: f['is_veg'],
            total: f['total'],
            date: f['timestamp'],
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

  List<Orders> findOrdersByID(int id) {
    return items;
  }

  List<Orders> findByvegfilter(int i) {
    List<Orders> itemslist = [];
    if (i == 0) {
      itemslist = items;
    }
    if (i == 1) {
      itemslist = items.where((test) => test.is_veg == true).toList();
    }
    if (i == 2) {
      itemslist = items.where((test) => test.is_veg == false).toList();
    }

    notifyListeners();
    return itemslist;
  }

  void logout() {
    items = [];
  }
}
