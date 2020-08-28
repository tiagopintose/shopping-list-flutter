import 'dart:async';
import 'dart:io';

import 'package:tiago_pinto_21703819/datasource/datasource.dart';
import 'package:tiago_pinto_21703819/models/Product.dart';

class Products{
  String name;
  int qty;
  double price;
  String observations;
  String assetPath;
  File file;


  DataSource dataSource = DataSource.getInstance();

  StreamController _controller = StreamController();

  Sink get _input => _controller.sink;

  Stream get output => _controller.stream;

  String assetsPath = 'lib/assets/logo.jpg';

  DataSource getInitialData() {

      var p1 = Product(
          name: 'Milk',
          price: 3.19,
          qty: 1,
          observations: 'Made in Açores',
          assetsPath: 'lib/assets/milk.jpg'
      );
      var p2 = Product(
          name: 'Cookies',
          price: 2.25,
          qty: 1,
          observations: 'Made in EUA',
          assetsPath: 'lib/assets/cookie.jpg',
      );
      var p3= Product(
          name: 'Mango',
          price: 5.35,
          qty: 1,
          observations: "Made in Brasil",
          assetsPath: 'lib/assets/mango2.jpg',
      );
      if(dataSource.isEmpty()) {
        dataSource.insert(p1);
        dataSource.insert(p3);
        dataSource.insert(p2);      }
      return dataSource;
  }
  void onAddName(String name) {
    this.name = name;
  }
  void onAddQty(int qty) {
    this.qty = qty;
  }
  void onAddPrice(double price) {
    this.price = price;
  }
  void onAddObservations(String string) {
    this.observations = string;
  }
  void onAddAssetPath(String string) {
    this.assetPath = string;
  }
  void onAddFile(File file) {
    this.file = file;
  }
  void onCreateProduct() {
    Product product;
    if(file != null) {
      product = Product(name: name, price: price, qty: qty, observations: observations, file: file);
    } else {
      product = Product(name: name, price: price, qty: qty, observations: observations, assetsPath: assetPath);
    }

    dataSource.insert(product);
    _input.add(dataSource);
  }
  double getTotalPrice() {
    return dataSource.getTotalPrice();
  }
  int getTotalProducts() {
    return dataSource.getTotalProducts();
  }
  void clear() {
    dataSource.clear();
    _input.add(dataSource);
  }
}