import 'package:flutter/material.dart';

import 'addProduct.dart';
import 'apiservices.dart';
import 'models/product_response.dart';
import 'widgets/mydrawer.dart';

class Store extends StatefulWidget {
  const Store({Key? key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  late ApiServices apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiServices();
  }

  @override
  Widget build(BuildContext context) {
    ApiServices()
        .getProducts()
        .then((value) => print("get data test : $value"));

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
                ).then((value) => setState(() {}));
              },
            ),
          ),
          // create list products
          Expanded(
            child: FutureBuilder(
              future: apiService.getProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Product>?> snapshot) {
                if (snapshot.hasData) {
                  List<Product>? products = snapshot.data?.reversed.toList();
                  return _generateListProduct(products);
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Center(
                    child: Text("Something wrong :("),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView _generateListProduct(List<Product>? data) {
    return ListView.builder(
      itemCount: data?.length ?? 0,
      itemBuilder: (context, index) {
        Product product = data![index];

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
              Text("Product " + product.itemName.toString()),
              Text("Item Code : " + product.itemCode.toString()),
              Text("Harga : " + product.price.toString()),
              Text("Stock : " + product.stock.toString()),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MaterialButton(
                    color: Colors.yellow,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddProduct(product: product)),
                      ).then((value) => setState(() {}));
                    },
                    child: Text("Edit"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                    child: Text("Hapus"),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Warning"),
                            content: Text(
                                "Are you sure want to delete data profile ${product.itemName}?"),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () {
                                  // Product productId =
                                  //     Product(id: product.id.toString());
                                  apiService
                                      .deleteProduct(product.id.toString())
                                      .then((hasil) {
                                    print("hasil hapus: $hasil");

                                    if (hasil.status == 200) {
                                      setState(() {});
                                      print(hasil.pesan);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  hasil.pesan.toString())));
                                    } else {
                                      print("gagal hapus");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Delete data failed")));
                                    }
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
