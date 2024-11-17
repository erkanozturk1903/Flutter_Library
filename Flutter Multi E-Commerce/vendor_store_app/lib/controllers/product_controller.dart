import 'dart:io';
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
            images: images);
        http.Response response = await http.post(
            Uri.parse('$uri/api/add-product'),
            body: product.toJson(),
            headers: <String, String>{
              "Content-Type": "appliccation/json; charset=UTF-8"
            });
        manageHttpResponse(
            response: response,
            context: context,
            onSuccess: () {
              showSnackBar(context, 'Product Uploaded');
            });
      } else {
        showSnackBar(context, 'Select Category');
      }
    } else {
      showSnackBar(context, 'select Images');
    }
  }
}
