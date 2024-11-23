import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vendor_store_app/global_variables.dart';
import 'package:vendor_store_app/models/subcategory.dart';

class SubcategoryController {
  Future<List<Subcategory>> getSubCategoriesByCategoryName(
      String categoryName) async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/category/$categoryName/subcategories"),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );

      if (response.statusCode == 200) {
        // API yanıtını decode et
        final dynamic decodedResponse = jsonDecode(response.body);
        
        // Yanıt bir Map ise ve 'subcategories' anahtarı varsa
        if (decodedResponse is Map && decodedResponse.containsKey('subcategories')) {
          final List<dynamic> data = decodedResponse['subcategories'];
          return data.map((subcategory) => Subcategory.fromJson(subcategory)).toList();
        }
        // Yanıt direkt bir List ise
        else if (decodedResponse is List) {
          return decodedResponse.map((subcategory) => Subcategory.fromJson(subcategory)).toList();
        }
        // Yanıt boş veya geçersiz ise
        else {
          print("Invalid response format");
          return [];
        }
      } else if (response.statusCode == 404) {
        print("subcategories not found");
        return [];
      } else {
        print('failed to fetch subcategories');
        return [];
      }
    } catch (e) {
      print('error fetching subcategories: $e');
      return [];
    }
  }
}