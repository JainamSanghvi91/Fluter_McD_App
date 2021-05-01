import 'package:McD/provider/p_category.dart';
import 'package:McD/provider/p_customer.dart';
import 'package:McD/provider/p_items.dart';
import 'package:McD/provider/p_orders.dart';
import 'package:McD/screens/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: P_Category(),
        ),
        ChangeNotifierProvider.value(
          value: P_Customer(),
        ),
        ChangeNotifierProvider.value(
          value: P_Items(),
        ),
        ChangeNotifierProvider.value(
          value: P_Orders(),
        ),
      ],
      child: MaterialApp(
        home: MainPage(),
      ),
    );
  }
}
