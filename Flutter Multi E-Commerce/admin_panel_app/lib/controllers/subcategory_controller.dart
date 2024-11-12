import 'dart:convert';

import 'package:admin_panel_app/global_variable.dart';
import 'package:admin_panel_app/models/subcategory.dart';
import 'package:admin_panel_app/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  uploadSubCategory({
    required String categoryId,
    required String categoryName,
    required dynamic pickedImage,
    required String subCategoryName,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dmiiiehov", "miraerkan");

      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: 'pickedImage',
          folder: 'categoryImages',
        ),
      );

      String image = imageResponse.secureUrl;

      Subcategory subcategory = Subcategory(
        id: '',
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subCategoryName: subCategoryName,
      );

      http.Response response = await http.post(
          Uri.parse("$uri/api/subcategories"),
          body: subcategory.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Upload SubCategory");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<Subcategory>> loadSubcategories() async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/subcategories'),
        headers: <String,String>{
           "Content-Type": "application/json; charset=UTF-8",
        }
      );

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Subcategory> subcategories = data
            .map((subcategory) => Subcategory.fromJson(subcategory))
            .toList();
        return subcategories;
      } else {
        //throw an exception if the server responsed with an error status code
        throw Exception('Failed to load Sub Category');
      }
    } catch (e) {
      throw Exception('Error loading Sub Category $e');
    }
  }
}
