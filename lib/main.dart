import 'package:flutter/material.dart';
import 'package:tiago_pinto_21703819/views/ProductsOverviewScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      title: 'Shopping List',
      home: ProductsOverviewScreen(),
    );
  }
}