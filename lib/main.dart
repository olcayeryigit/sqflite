import 'package:flutter/material.dart';
import 'package:locale_db/screens/product_list.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ProductList());
  }
}
