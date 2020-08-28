import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiago_pinto_21703819/models/Product.dart';
import 'package:tiago_pinto_21703819/shake/shake.dart';
import 'package:tiago_pinto_21703819/views/ProductsOverviewScreen.dart';
import 'package:tiago_pinto_21703819/widgets/DrawProductWidget.dart';

class ProductItem extends StatefulWidget {
  Product product;

  double oldPrice;

  ShakeDetector detector;

  ProductItem(Product product, ShakeDetector detector) {
    this.product = product;
    this.oldPrice = this.product.price;
    this.detector = detector;
  }

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.product.isRemoved) {
      return Container();
    } else {
      return Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection dir) {
            if (dir == DismissDirection.startToEnd) {
              setState(() {
                widget.product.isRemoved = true;
                ProductsOverviewScreen.of(context).rebuild();
              });
            } else {
              setState(() {
                if (widget.product.color == Colors.white) {
                  widget.product.color = Colors.lightGreen;
                  widget.product.isShopped = true;
                } else {
                  widget.product.color = Colors.white;
                  widget.product.isShopped = false;
                }
              });
            }
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(dir == DismissDirection.startToEnd
                  ? 'The item ${widget.product.name} was removed.'
                  : widget.product.color == Colors.lightGreen
                  ?'The item ${widget.product.name} was acquired.'
                  : 'The item ${widget.product.name} was not acquired'),
              action: SnackBarAction(
                label: 'UNDO',
                onPressed: () {
                  if (dir == DismissDirection.startToEnd) {
                    setState(() {
                      widget.product.isRemoved = false;
                      ProductsOverviewScreen.of(context).rebuild();
                    });
                  } else {
                    setState(() {
                      if (widget.product.color == Colors.white) {
                        widget.product.color = Colors.lightGreen;
                        widget.product.isShopped = true;
                      } else {
                        widget.product.color = Colors.white;
                        widget.product.isShopped = false;
                      }
                    });
                  }
                },
              ),
            ));
          },
          background: Container(
            color: Colors.red,
            child: Icon(Icons.delete),
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: Container(
            color: Colors.green,
            child: Icon(Icons.shopping_cart),
            alignment: Alignment.centerRight,
          ),
          child: DrawProductWidget(
            product: widget.product,
            oldPrice: widget.oldPrice,
            detector: widget.detector,
          ));
    }
  }
}
