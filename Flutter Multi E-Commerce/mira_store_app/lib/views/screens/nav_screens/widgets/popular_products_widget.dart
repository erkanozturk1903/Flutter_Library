import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mira_store_app/controllers/product_controller.dart';
import 'package:mira_store_app/provider/product_provider.dart';
import 'package:mira_store_app/views/screens/nav_screens/widgets/product_item_widget.dart';

class PopularProductsWidget extends ConsumerStatefulWidget {
  const PopularProductsWidget({super.key});

  @override
  ConsumerState<PopularProductsWidget> createState() =>
      _PopularProductsWidgetState();
}

class _PopularProductsWidgetState extends ConsumerState<PopularProductsWidget> {
  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  Future<void> _fetchProduct() async {
    final ProductController productController = ProductController();
    try {
      final products = await productController.loadPopularProduct();
      ref.read(productProvider.notifier).setProduct(products);
    } catch (e) {
      print("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
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
  }
}
