// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:admin_panel_app/global_variable.dart';
import 'package:admin_panel_app/models/category.dart';
import 'package:admin_panel_app/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required String name,
    required dynamic pickedImage,
    required dynamic pickedBanner,
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

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedBanner,
          identifier: 'pickedBanner',
          folder: 'categoryImages',
        ),
      );
      String banner = bannerResponse.secureUrl;

      Category category = Category(
        id: "",
        name: name,
        image: image,
        banner: banner,
      );

      http.Response response = await http.post(Uri.parse("$uri/api/categories"),
          body: category.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Upload Category");
        },
      );
    } catch (e) {
      print('Error uploading to cloudinary: $e');
    }
  }

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
