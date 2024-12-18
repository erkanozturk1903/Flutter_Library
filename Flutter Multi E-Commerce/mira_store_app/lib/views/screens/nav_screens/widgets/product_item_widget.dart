import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mira_store_app/models/product.dart';
import 'package:mira_store_app/views/screens/detail/screens/product_detail_screen.dart';

class ProductItemWidget extends StatelessWidget {
  final Product product;
  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        width: 170,
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: const Color(0xffF2F2F2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      product.images[0],
                      height: 170,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 15,
                      right: 2,
                      child: Image.asset(
                        'assets/icons/love.png',
                        width: 26,
                        height: 26,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                product.productName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  color: const Color(
                    0xff212121,
                  ),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                product.category,
                style: GoogleFonts.quicksand(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff868D94)),
              ),
              Text(
                '\n${product.productPrice.toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
