import 'dart:convert';
import 'package:mira_store_app/global_variable.dart';
import 'package:mira_store_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<List<Product>> loadPopularProduct() async {
    try {
      final apiUrl = '$uri/api/popular-products';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);

        if (decodedData['success'] == true && decodedData['products'] != null) {
          final List<dynamic> productsData = decodedData['products'];
          return productsData.map((data) => Product.fromMap(data)).toList();
        } else {
          return [];
        }
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Product>> loadRecommendedProducts() async {
    try {
      final apiUrl = '$uri/api/recommended-products';

      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);

        if (decodedData['success'] == true && decodedData['products'] != null) {
          final List<dynamic> productsData = decodedData['products'];
          return productsData.map((data) => Product.fromMap(data)).toList();
        } else {
          return [];
        }
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception(
            'Failed to load recommended products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load recommended products: $e');
    }
  }

  Future<List<Product>> loadProductByCategory(String category) async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products-by-category/$category'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      }else {
        throw Exception('Failed to load products by products');
      }
    } catch (e) {
     throw Exception('Failed to load recommended products: $e');
    }
  }
}
