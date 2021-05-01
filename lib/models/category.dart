import 'package:flutter/cupertino.dart';

class Categories with ChangeNotifier {
  final int categoryId;
  final String categoryName;

  Categories({
    @required this.categoryId,
    @required this.categoryName,
  });
}
