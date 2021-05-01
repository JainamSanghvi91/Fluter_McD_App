import 'package:McD/models/category.dart';
import 'package:McD/models/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class P_Customer with ChangeNotifier {
  List<Customer> items = [];

  Future<void> fetchcustomer() async {
    final url = 'https://hackathon-2.herokuapp.com/api/customer/';
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
      final List<Customer> loadedcategory = [];
      res.forEach((f) {
        loadedcategory.add(
          Customer(name: f['c_name'], phone: f['phone'], is_veg: f['is_veg']),
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

  List<Customer> findByvegfilter(int i) {
    List<Customer> itemslist = [];
    i == 0
        ? itemslist = items.where((test) => test.is_veg == true).toList()
        : itemslist = items.where((test) => test.is_veg == false).toList();
    notifyListeners();
    return itemslist;
  }
}
