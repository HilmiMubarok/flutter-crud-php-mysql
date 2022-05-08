import 'package:flutter/material.dart';
import 'package:flutter_application_1/store.dart';
import 'package:flutter_application_1/widgets/myDrawer.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Produk'),
      ),
      drawer: MyDrawer(),
      // create list products
      body: Column(
        children: <Widget>[
          Container(
            width: 120,
            margin: EdgeInsets.all(20),
            child: MaterialButton(
              color: Colors.teal,
              textColor: Colors.white,
              child: Row(
                children: [Icon(Icons.arrow_back), Text("Kembali")],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Store()),
                );
              },
            ),
          ),
          // create list products
        ],
      ),
    );
  }
}
