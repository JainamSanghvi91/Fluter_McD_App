import 'package:McD/models/category.dart';
import 'package:McD/models/httpException.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class P_Category with ChangeNotifier {
  //String urlFront = 'https://hackathon-2.herokuapp.com';
  List<Categories> items = [];

  Future<void> fetchcategory() async {
    final url = 'https://hackathon-2.herokuapp.com/api/category/';
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
      final List<Categories> loadedcategory = [];
      res.forEach((f) {
        loadedcategory.add(
          Categories(
            categoryName: f['c_name'],
            categoryId: f['id'],
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

  Categories findCategoryByID(int id) {
    return items.firstWhere((test) => test.categoryId == id);
  }

  void logout() {
    items = [];
  }
}
