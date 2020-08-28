
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tiago_pinto_21703819/blocs/Products.dart';
import 'package:tiago_pinto_21703819/models/Product.dart';
import 'package:tiago_pinto_21703819/shake/shake.dart';
import 'package:tiago_pinto_21703819/views/AddProductScreen.dart';
import 'package:tiago_pinto_21703819/widgets/ProductItem.dart';

class ProductsOverviewScreen extends StatefulWidget {

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();

  static _ProductsOverviewScreenState of(BuildContext context) {
    return context.ancestorStateOfType(const TypeMatcher<_ProductsOverviewScreenState>());
  }
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
   Products products = Products();
   var clear = false;
   ShakeDetector detector;
  @override
  void initState() {
    super.initState();
    detector = ShakeDetector.waitForStart(onPhoneShake: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Delete list ?'),
          content: Text("You shake the phone. Are you sure that you want to delete the whole list?"),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Confirm"),
              onPressed: () {
                setState(() {
                  products.clear();
                  clear = true;
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        )
      );
    });
    detector.startListening();
  }

  @override
  Widget build(BuildContext context) {
    var loadedList;
    !clear?loadedList = products.getInitialData():loadedList = [];
    return Scaffold(
        appBar: AppBar(
          title: Text('My List'),
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${products.getTotalProducts()} products  ', style: TextStyle(fontSize: 20,color: Colors.white),)
              ],
            )
          ],
        ),
        body: StreamBuilder(
          stream: products.output,
          initialData: loadedList,
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.getAll().length,
                itemBuilder: (context, index) {
                  Product item = snapshot.data.get(index);
                  return ProductItem(
                      item,
                      detector
                  );
                }
            );
          }
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('New Item'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductScreen(products: products, detector: detector,))
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.green,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('  Total Price: ', style: TextStyle(fontSize: 20,color: Colors.white),),
                Spacer(),
                Text('${products.getTotalPrice().toStringAsFixed(2)} €  ', style: TextStyle(fontSize: 20,color: Colors.white),)

              ],
            ),
          )
        ),
    );
  }
  void rebuild() {
    setState(() {
    });
  }
  void detect() {
    initState();
  }
}