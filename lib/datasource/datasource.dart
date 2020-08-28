import 'package:tiago_pinto_21703819/models/Product.dart';

class DataSource {

  final _datasource = [];
  static DataSource _instance;

  DataSource._internal();


  static DataSource getInstance() {
    if(_instance == null) {
      _instance = DataSource._internal();
    }
    return _instance;
  }

  void insert(operation) => _datasource.add(operation);

  Product get(index) => _datasource[index];
  void clear() {
    _datasource.clear();
  }
  double getTotalPrice() {
    double result = 0.0;
    for(Product p in _datasource) {
      if(!p.isRemoved) {
        var r= p.qty * p.price;
        result += r;
      }

    }
    return result;
  }
  int getTotalProducts() {
    int result = 0;
    for(Product p in _datasource) {
      if(!p.isRemoved) {
        result += p.qty;
      }
    }
    return result;
  }
  void remove(Product p) {
    _datasource.remove(p);
  }
  void undoRemove(Product p) {
    _datasource.add(p);
  }
  List getAll() => _datasource;
  bool isEmpty() {
    if(_datasource.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}