import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mira_store_app/global_variable.dart';
import 'package:mira_store_app/models/banner.dart';

class BannerController {
  

  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/banner'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      });

      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        //throw an exception if the server responsed with an error status code
        throw Exception('Failed to load Banners');
      }
    } catch (e) {
      throw Exception('Error loading Banners $e');
    }
  }
}