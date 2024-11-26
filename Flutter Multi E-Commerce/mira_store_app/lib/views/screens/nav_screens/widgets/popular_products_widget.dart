import 'package:flutter/material.dart';
import 'package:mira_store_app/controllers/product_controller.dart';
import 'package:mira_store_app/models/product.dart';
import 'package:mira_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';

class PopularProductsWidget extends StatefulWidget {
  const PopularProductsWidget({super.key});

  @override
  State<PopularProductsWidget> createState() => _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends State<PopularProductsWidget> {
  late Future<List<Product>> futurePopularProducts;
  final ProductController _productController = ProductController();

  @override
  void initState() {
    super.initState();
    futurePopularProducts = _productController.loadPopularProduct();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      futurePopularProducts = _productController.loadPopularProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: futurePopularProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              textAlign: TextAlign.center,
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Popular Products Available'),
          );
        }

        final products = snapshot.data!;
        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              try {
                final product = products[index];
                return ProductItemWidget(product: product);
              } catch (e) {
                print('Error building product at index $index: $e');
                return const SizedBox.shrink(); // Hatalı ürünü gösterme
              }
            },
          ),
        );
      },
    );
  }
}
