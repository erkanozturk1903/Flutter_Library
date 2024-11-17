import 'dart:convert';

import 'package:mira_store_app/global_variable.dart';
import 'package:mira_store_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  //Define a function that returns a future contaning list of the product model object
  Future<List<Product>> loadPopularProduct() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/popular-products"),
        headers: <String, String>{
          'Content-Type': 'application/json chartset=UTF-8'
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load popular products');
      }
    } catch (e) {
      throw Exception('Error loading product: $e');
    }
  }
}
