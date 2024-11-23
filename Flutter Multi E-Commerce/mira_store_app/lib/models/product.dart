import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String description;
  final String category;
  final String vendorId;
  final String fullName;
  final String subCategory;
  final List<String> images;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.description,
    required this.category,
    required this.vendorId,
    required this.fullName,
    required this.subCategory,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'description': description,
      'category': category,
      'vendorId': vendorId,
      'fullName': fullName,
      'subCategory': subCategory,
      'images': images,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    try {
      return Product(
        id: map['_id']?.toString() ?? '',
        productName: map['productName']?.toString() ?? '',
        productPrice: int.tryParse(map['productPrice']?.toString() ?? '0') ?? 0,
        quantity: int.tryParse(map['quantity']?.toString() ?? '0') ?? 0,
        description: map['description']?.toString() ?? '',
        category: map['category']?.toString() ?? '',
        vendorId: map['vendorId']?.toString() ?? '',
        fullName: map['fullName']?.toString() ?? '',
        subCategory: map['subCategory']?.toString() ?? '',
        images: List<String>.from(map['images'] ?? []),
      );
    } catch (e) {
      print('Error parsing Product from map: $e');
      print('Problematic map: $map');
      rethrow;
    }
  }

  String toJson() => json.encode(toMap());
}