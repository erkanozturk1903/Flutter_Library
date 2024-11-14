// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mira_store_app/global_variable.dart';
import 'package:mira_store_app/models/category.dart';

class CategoryController {
 

  // Loaded the uploaded category

  Future<List<Category>> loadCaategories() async{
     try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/categories'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      });

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        //throw an exception if the server responsed with an error status code
        throw Exception('Failed to load Category');
      }
    } catch (e) {
      throw Exception('Error loading Category $e');
    }
  }
}