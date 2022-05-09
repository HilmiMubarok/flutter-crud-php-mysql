import 'dart:convert';

import 'package:http/http.dart' show Client;

import 'models/base_response.dart';
import 'models/product_response.dart';

class ApiServices {
  final String baseUrl = 'http://192.168.38.146/api_hilmiflutter/';
  Client client = Client();

  Future<List<Product>?> getProducts() async {
    Uri uri = Uri.parse(baseUrl);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      return productFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<BaseResponse> addProduct(Product data) async {
    final response = await client.post(
      Uri.parse("$baseUrl?page=add-product"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "item_code": data.itemCode,
        "item_name": data.itemName,
        "price": data.price,
        "stock": data.stock,
      },
    );
    if (response.statusCode == 200) {
      print("success tambah" + response.body);
      return baseResponseFromJson(response.body);
    } else {
      print("gagal add" + response.body);
      throw Exception('Failed to add post: $data');
    }
  }

  Future<BaseResponse> updateProduct(Product data) async {
    final response = await client.post(
      Uri.parse("$baseUrl?page=update-product"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {
        "id": data.id,
        "item_code": data.itemCode,
        "item_name": data.itemName,
        "price": data.price,
        "stock": data.stock,
      },
    );
    if (response.statusCode == 200) {
      print("success update" + response.body);
      return baseResponseFromJson(response.body);
    } else {
      print("gagal update" + response.body);
      throw Exception('Failed to update post: $data');
    }
  }

  Future<BaseResponse> deleteProduct(String data) async {
    final response = await client.post(
      Uri.parse("$baseUrl?page=delete-product"),
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
      encoding: Encoding.getByName('utf-8'),
      body: {"id": data},
    );

    if (response.statusCode == 200) {
      print("hapooos" + response.body);
      return baseResponseFromJson(response.body);
    } else {
      print("gagal hapus" + response.body);
      throw Exception('Failed to delete post: $data');
    }
  }
}
