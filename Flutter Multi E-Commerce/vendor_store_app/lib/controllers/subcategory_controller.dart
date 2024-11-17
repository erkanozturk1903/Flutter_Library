import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:vendor_store_app/global_variables.dart';
import 'package:vendor_store_app/models/subcategory.dart';

class SubcategoryController {
  Future<List<Subcategory>> getSubcategoryByCategoryName(
      String categoryName) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/category/$categoryName/subcategories"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return data
              .map((subcategory) => Subcategory.fromJson(subcategory))
              .toList();
        } else {
          print("subcategoreis not found");
          return [];
        }
      } else if (response.statusCode == 404) {
        print("subcategoreis not found");
         return [];
      } else {
        print("failed to fetch subcategories");
         return [];
      }
    } catch (e) {
      print(e);
       return [];
    }
  }
}
