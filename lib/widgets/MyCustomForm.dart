import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiago_pinto_21703819/models/Product.dart';
import 'package:tiago_pinto_21703819/shake/shake.dart';
import 'package:tiago_pinto_21703819/widgets/MyCustomFormField.dart';
import 'package:validators/validators.dart' as validator;

class MyCustomForm extends StatefulWidget {
  final products;
  bool isAdd;
  Product product;
  ShakeDetector detector;

  MyCustomForm({this.products, this.isAdd, this.product, this.detector});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  var _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    if (widget.isAdd) {
      return Scaffold(
        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.green,
                      )),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: _image != null
                            ? Image.file(_image)
                            : Image.asset('lib/assets/logo.jpg'),
                      ),
                    ),
                  ),
                  MyCustomFormField(
                    label: 'Name',
                    text: "e.g bread",
                    isText: true,
                    validator: (String value) {
                      if (value.isEmpty || validator.isNumeric(value)) {
                        return 'Enter the name of product';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      widget.products.onAddName(value);
                      if (_image != null) {
                        widget.products.onAddFile(_image);
                      } else {
                        widget.products.onAddAssetPath('lib/assets/logo.jpg');
                      }
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        width: halfMediaWidth,
                        child: MyCustomFormField(
                          label: 'Quantity',
                          text: "e.g 12",
                          validator: (String value) {
                            if (validator.isNumeric(value)) {
                              var num = int.parse(value);
                              if (num < 0) {
                                return 'Enter a positive number';
                              }
                            }
                            if (value.isEmpty || !validator.isNumeric(value)) {
                              return 'Enter a  integer number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            var num = int.parse(value);
                            widget.products.onAddQty(num);
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: halfMediaWidth,
                        child: MyCustomFormField(
                          label: 'Price/unit',
                          text: "e.g 0.45",
                          validator: (String value) {
                            if (!value.isEmpty && validator.isFloat(value)) {
                              var num = double.parse(value);
                              if (num < 0) {
                                return 'Enter a positive number';
                              }
                            }
                            if (value.isEmpty || !validator.isFloat(value)) {
                              return 'Enter the price';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            var num = double.parse(value);
                            widget.products.onAddPrice(num);
                          },
                        ),
                      ),
                    ],
                  ),
                  MyCustomFormField(
                    label: 'Observations (Optional)',
                    text: "e.g whole wheat bread",
                    isText: true,
                    validator: (String value) {
                      return null;
                    },
                    onSaved: (String value) {
                      widget.products.onAddObservations(value);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          label: Text('Save'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.products.onCreateProduct();
              widget.detector.startListening();
              Navigator.of(context).pop();
            }
          },
        ),
      );
    } else {
      return Scaffold(
        body: ListView(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      width: 150,
                      height: 150,
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 1,
                        color: Colors.green,
                      )),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: _image != null
                            ? Image.file(_image)
                            : widget.product.file != null
                                ? Image.file(widget.product.file)
                                : Image.asset(widget.product.assetsPath),
                      ),
                    ),
                  ),
                  MyCustomFormField(
                    isText: true,
                    isEdit: true,
                    label: 'Name',
                    text: widget.product.name,
                    validator: (String value) {
                      if (value.isEmpty || validator.isNumeric(value)) {
                        return 'Enter the name of product';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      widget.product.name = value;
                      if (_image != null) {
                        widget.product.file = _image;
                      }
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        width: halfMediaWidth,
                        child: MyCustomFormField(
                          label: 'Quantity',
                          isEdit: true,
                          text: widget.product.qty.toString(),
                          validator: (String value) {
                            if (validator.isNumeric(value)) {
                              var num = int.parse(value);
                              if (num < 0) {
                                return 'Enter a positive number';
                              }
                            }
                            if (value.isEmpty || !validator.isNumeric(value)) {
                              return 'Enter a number';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            var num = int.parse(value);
                            widget.product.qty = num;
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: halfMediaWidth,
                        child: MyCustomFormField(
                          label: 'Price/unit',
                          isEdit: true,
                          text: widget.product.price.toString(),
                          validator: (String value) {
                            if (!value.isEmpty && validator.isFloat(value)) {
                              var num = double.parse(value);
                              if (num < 0) {
                                return 'Enter a positive number';
                              }
                            }
                            if (value.isEmpty || !validator.isFloat(value)) {
                              return 'Enter the price';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            var num = double.parse(value);
                            widget.product.price = num;
                          },
                        ),
                      ),
                    ],
                  ),
                  MyCustomFormField(
                    label: 'Observations',
                    isEdit: true,
                    text: widget.product.observations,
                    isText: true,
                    validator: (String value) {
                      return null;
                    },
                    onSaved: (String value) {
                      widget.product.observations = value;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.save),
          label: Text('Save'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              widget.detector.startListening();
              Navigator.of(context).pop();
            }
          },
        ),
      );
    }
  }
}
