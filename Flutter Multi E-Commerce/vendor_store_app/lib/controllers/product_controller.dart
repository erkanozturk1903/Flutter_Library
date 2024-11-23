import 'dart:io';
import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:vendor_store_app/global_variables.dart';
import 'package:vendor_store_app/models/product.dart';
import 'package:vendor_store_app/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class ProductController {
  Future<void> uploadProduct({
    required String productName,
    required int productPrice,
    required int quantity,
    required String description,
    required String category,
    required String vendorId,
    required String fullName,
    required String subCategory,
    required List<File>? pickedImages,
    required context,
  }) async {
    try {
      if (pickedImages != null) {
        final cloudinary = CloudinaryPublic("dmiiiehov", "miraerkan");
        List<String> images = [];
        
        for (var i = 0; i < pickedImages.length; i++) {
          CloudinaryResponse cloudinaryResponse = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(
              pickedImages[i].path,
              folder: productName,
            ),
          );
          images.add(cloudinaryResponse.secureUrl);
        }

        if (category.isNotEmpty && subCategory.isNotEmpty) {
          final Product product = Product(
            id: '',
            productName: productName,
            productPrice: productPrice,
            quantity: quantity,
            description: description,
            category: category,
            vendorId: vendorId,
            fullName: fullName,
            subCategory: subCategory,
            images: images,
          );

          // Ürün verilerini Map olarak al ve JSON'a çevir
          final Map<String, dynamic> productMap = product.toMap();
          final String jsonData = json.encode(productMap);

          print('Sending JSON: $jsonData'); // Debug için

          final response = await http.post(
            Uri.parse('$uri/api/add-product'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonData,
          );

          print('Response Status: ${response.statusCode}');
          print('Response Body: ${response.body}');

          manageHttpResponse(
            response: response,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Product Uploaded Successfully');
            },
          );
        } else {
          showSnackBar(context, 'Please select Category and SubCategory');
        }
      } else {
        showSnackBar(context, 'Please select Images');
      }
    } catch (e) {
      print('Error in uploadProduct: $e');
      showSnackBar(context, 'Error uploading product: ${e.toString()}');
    }
  }
}