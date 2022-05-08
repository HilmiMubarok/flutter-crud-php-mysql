import 'package:flutter/material.dart';

import 'package:flutter_application_1/addProduct.dart';
import 'widgets/myDrawer.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Store'),
      ),
      drawer: MyDrawer(),
      // create list products
      body: Column(
        children: <Widget>[
          Container(
            width: 150,
            margin: EdgeInsets.all(20),
            child: MaterialButton(
              color: Colors.teal,
              textColor: Colors.white,
              child: Row(
                children: [Icon(Icons.add), Text("Add Product")],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              },
            ),
          ),
          // create list products
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Product " + index.toString()),
                      Text("Item Code : " + index.toString()),
                      Text("Harga : Rp. 200.000"),
                      Text("Stock : 5"),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          MaterialButton(
                            color: Colors.teal,
                            textColor: Colors.white,
                            onPressed: () {},
                            child: Text("Detail"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            color: Colors.yellow,
                            onPressed: () {},
                            child: Text("Edit"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          MaterialButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {},
                            child: Text("Hapus"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
