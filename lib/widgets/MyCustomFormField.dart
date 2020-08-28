import 'package:flutter/material.dart';

class MyCustomFormField extends StatelessWidget {
  final String text;
  final Function validator;
  final Function onSaved;
  final bool isText;
  final bool isEdit;
  final String label;


  MyCustomFormField({
    this.text,
    this.validator,
    this.onSaved,
    this.isText = false,
    this.isEdit = false,
    this.label
  });
  @override
  Widget build(BuildContext context) {

      return Padding(
        padding: EdgeInsets.all(10.0),
        child: TextFormField(
          initialValue: isEdit?text:'',
          decoration: InputDecoration(
            labelText: label,
            hintText: !isEdit? text: '',
            contentPadding: EdgeInsets.all(16.0),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validator: validator,
          onSaved: onSaved,
          keyboardType: isText ? TextInputType.text : TextInputType.number,
        ),
      );

  }
}