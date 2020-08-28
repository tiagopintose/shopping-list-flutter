import 'package:flutter/material.dart';
import 'package:tiago_pinto_21703819/shake/shake.dart';
import 'package:tiago_pinto_21703819/widgets/MyCustomForm.dart';

class AddProductScreen extends StatelessWidget {

  final products;
  ShakeDetector detector;

  AddProductScreen({this.products, this.detector});

  @override
  Widget build(BuildContext context) {
    detector.stopListening();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            detector.startListening();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: MyCustomForm(products: this.products,isAdd: true,detector: detector,),
    );
  }
}