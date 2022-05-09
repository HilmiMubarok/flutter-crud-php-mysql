import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'models/base_response.dart';
import 'models/product_response.dart';

class ApiServices {
  final baseUrl = Uri.parse("http://192.168.89.146/api_hilmiflutter/");
  Client client = Client();

  Future<List<Product>?> getProducts() async {
    final response = await client.get(baseUrl);
    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> addProduct(Product data) async {
    final response = await client.post(
      Uri.parse("http://192.168.89.146/api_hilmiflutter/?page=add-product"),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: ({
        "item_code": data.itemCode,
        "item_name": data.itemName,
        "price": data.price,
        "stock": data.stock,
      }),
    );
    if (response.statusCode == 201) {
      print("success" + response.body);
      return true;
    } else {
      print("failed" + response.body);
      return false;
    }
  }

  Future<BaseResponse> deleteProduct(String data) async {
    final response = await client.delete(
      Uri.parse("http://192.168.89.146/api_hilmiflutter/?page=delete-product"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: jsonEncode({"id": data}),
    );

    if (response.statusCode == 200) {
      print("hapooos" + response.body);
      return baseResponseFromJson(response.body);
    } else {
      print("gagal");
      throw Exception('Failed to delete post: $data');
    }
  }
}
