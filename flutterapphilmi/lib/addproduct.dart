import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product_response.dart';

import 'apiservices.dart';
import 'widgets/myDrawer.dart';

// final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AddProduct extends StatefulWidget {
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  bool _isLoading = false;

  ApiServices _apiService = ApiServices();

  // bool? _isFieldProductValid;

  // bool? _isFieldCodeValid;

  // bool? _isFieldStockValid;

  // bool? _isFieldPriceValid;

  TextEditingController _controllerProduct = TextEditingController();

  TextEditingController _controllerCode = TextEditingController();

  TextEditingController _controllerPrice = TextEditingController();

  TextEditingController _controllerStock = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldState,
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
                      child: RaisedButton(
                        onPressed: () {
                          // if (_isFieldProductValid == null ||
                          //     _isFieldCodeValid == null ||
                          //     _isFieldStockValid == null ||
                          //     _isFieldPriceValid == null) {
                          //   _scaffoldState.currentState.showSnackBar(
                          //     SnackBar(
                          //       content: Text("Please fill all field"),
                          //     ),
                          //   );
                          //   return;
                          // }
                          setState(() => _isLoading = true);
                          String productname =
                              _controllerProduct.text.toString();
                          String productcode = _controllerCode.text.toString();
                          String stock = _controllerStock.text.toString();
                          String price = _controllerPrice.text.toString();
                          Product product = Product(
                              itemCode: productcode,
                              itemName: productname,
                              price: price,
                              stock: stock);
                          _apiService.addProduct(product).then((isSuccess) {
                            setState(() => _isLoading = false);
                            if (isSuccess) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Submit data failed")));
                            }
                          });
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
              _isLoading ? CircularProgressIndicator() : Container(),
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
        // errorText: _isFieldProductValid == null || _isFieldProductValid
        //     ? null
        //     : "Full name is required",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldProductValid) {
      //     setState(() => _isFieldProductValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldCode() {
    return TextField(
      controller: _controllerCode,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Item Code",
        // errorText: _isFieldCodeValid == null || _isFieldCodeValid
        //     ? null
        //     : "Email is required",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldCodeValid) {
      //     setState(() => _isFieldCodeValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldStock() {
    return TextField(
      controller: _controllerStock,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Stock",
        // errorText: _isFieldStockValid == null || _isFieldStockValid
        //     ? null
        //     : "Age is required",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldStockValid) {
      //     setState(() => _isFieldStockValid = isFieldValid);
      //   }
      // },
    );
  }

  Widget _buildTextFieldPrice() {
    return TextField(
      controller: _controllerPrice,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Price",
        // errorText: _isFieldStockValid == null || _isFieldStockValid
        //     ? null
        //     : "Age is required",
      ),
      // onChanged: (value) {
      //   bool isFieldValid = value.trim().isNotEmpty;
      //   if (isFieldValid != _isFieldStockValid) {
      //     setState(() => _isFieldStockValid = isFieldValid);
      //   }
      // },
    );
  }
}
