import 'dart:io';

import 'package:flutter/material.dart';

class Product {
  String name;

  double price;

  int qty;

  bool isRemoved;
  Color color;
  bool isShopped;
  String observations;
  File file;
  String assetsPath;

  Product({
    @required this.name,
    @required this.price,
    @required this.qty,
    @required this.observations,
    this.isRemoved = false,
    this.color = Colors.white,
    this.isShopped = false,
    this.file,
    this.assetsPath,
  });

  bool equals(Product p) {
    if(p.qty == this.qty && p.price == this.price && p.name == this.name) {
      return true;
    } else {
      return false;
    }
  }

  void set setPrice(num) => this.price = num;

  void setIsRemove(bool b) {
    this.isRemoved = b;
  }

}