import 'package:flutter/material.dart';
import 'package:tiago_pinto_21703819/models/Product.dart';
import 'package:tiago_pinto_21703819/shake/shake.dart';
import 'package:tiago_pinto_21703819/widgets/MyCustomForm.dart';

class EditProductScreen extends StatelessWidget {
  Product product;

  ShakeDetector detector;
  EditProductScreen({this.product, this.detector});
  @override
  Widget build(BuildContext context) {
    detector.stopListening();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Item"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            detector.startListening();
            Navigator.of(context).pop();
          },
        ),
      ),
      body:MyCustomForm(isAdd: false,product: product, detector: detector,)
      );
  }
}