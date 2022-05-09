import 'package:flutter/material.dart';

import 'apiservices.dart';
import 'models/product_response.dart';
import 'widgets/myDrawer.dart';

// final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddProduct extends StatefulWidget {
  AddProduct({this.product});

  Product? product;

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _isLoading = false;

  ApiServices _apiService = ApiServices();

  TextEditingController _controllerProduct = TextEditingController();
  TextEditingController _controllerCode = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerStock = TextEditingController();

  @override
  void initState() {
    _controllerProduct.text = widget.product?.itemName ?? "";
    _controllerCode.text = widget.product?.itemCode ?? "";
    _controllerPrice.text = widget.product?.price ?? "";
    _controllerStock.text = widget.product?.stock ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldState,
      appBar: AppBar(
        title:
            widget.product != null ? Text('Edit Product') : Text('Add Product'),
      ),
      drawer: MyDrawer(),
      // create list products
      body: ListView(
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
                Navigator.pop(context);
              },
            ),
          ),
          Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    _buildTextFieldproduct(),
                    _buildTextFieldCode(),
                    _buildTextFieldStock(),
                    _buildTextFieldPrice(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : RaisedButton(
                              onPressed: () {
                                setState(() => _isLoading = true);
                                String productname =
                                    _controllerProduct.text.toString();
                                String productcode =
                                    _controllerCode.text.toString();
                                String stock = _controllerStock.text.toString();
                                String price = _controllerPrice.text.toString();
                                Product product = Product(
                                    itemCode: productcode,
                                    itemName: productname,
                                    price: price,
                                    stock: stock);

                                if (widget.product != null) {
                                  product.id = widget.product?.id;
                                  _apiService
                                      .updateProduct(product)
                                      .then((value) {
                                    setState(() => _isLoading = false);
                                    Navigator.pop(context);
                                  });
                                } else {
                                  _apiService.addProduct(product).then((hasil) {
                                    setState(() => _isLoading = false);
                                    if (hasil.status == 200) {
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Submit data failed")));
                                    }
                                  });
                                }
                              },
                              child: Text(
                                "Submit".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.teal,
                            ),
                    )
                  ],
                ),
              ),
            ],
          )
          // create list products
        ],
      ),
    );
  }

  Widget _buildTextFieldproduct() {
    return TextField(
      controller: _controllerProduct,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        labelText: "Item Name",
      ),
    );
  }

  Widget _buildTextFieldCode() {
    return TextField(
      controller: _controllerCode,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Item Code",
      ),
    );
  }

  Widget _buildTextFieldStock() {
    return TextField(
      controller: _controllerStock,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Stock",
      ),
    );
  }

  Widget _buildTextFieldPrice() {
    return TextField(
      controller: _controllerPrice,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Price",
      ),
    );
  }
}
