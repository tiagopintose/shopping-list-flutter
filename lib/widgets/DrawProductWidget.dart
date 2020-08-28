import 'package:flutter/material.dart';
import 'package:tiago_pinto_21703819/models/Product.dart';
import 'package:tiago_pinto_21703819/shake/shake.dart';
import 'package:tiago_pinto_21703819/views/EditProductScreen.dart';
import 'package:tiago_pinto_21703819/views/ProductsOverviewScreen.dart';

class DrawProductWidget extends StatefulWidget {
  final Product product;

  double oldPrice;

  ShakeDetector detector;

  DrawProductWidget({this.product, this.oldPrice, this.detector});


  @override
  State<StatefulWidget> createState() => _DrawProductWidgetState();



}
class _DrawProductWidgetState extends State<DrawProductWidget> {
  @override
  Widget build(BuildContext context) {
    double priceToShow = widget.product.price * widget.product.qty;
    var roundPrice = priceToShow.toStringAsFixed(2);
    if(widget.product.isShopped) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProductScreen(product: widget.product,detector: widget.detector,))
          );
        },
        child: Container(
          height: 70,
          child: Card(
            color: widget.product.color,
            elevation: 5,
            child: Container(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        child: widget.product.file != null ?  Image.file(widget.product.file): Image.asset(widget.product.assetsPath),
                        backgroundColor: widget.product.color,
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(this.widget.product.name, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('$roundPrice €'),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Qty: ${widget.product.qty}   ', style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditProductScreen(product: widget.product, detector: widget.detector,))
          );
        },
        child: Container(
          height: 70,
          child: Card(
            color: widget.product.color,
            elevation: 5,
            child: Container(
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        child: widget.product.file != null ?  Image.file(widget.product.file): Image.asset(widget.product.assetsPath),
                        backgroundColor: widget.product.color,
                      )
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(this.widget.product.name, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('$roundPrice €'),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if(widget.product.qty > 0) {
                              widget.product.qty-=1;
                              ProductsOverviewScreen.of(context).rebuild();
                            }
                          });

                        },
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${this.widget.product.qty}')
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            widget.product.qty+=1;
                            ProductsOverviewScreen.of(context).rebuild();
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

  }
}