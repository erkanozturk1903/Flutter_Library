// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShippingAddressScreen extends StatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.96),
        elevation: 0,
        title: Text(
          'Delivery',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.7,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Where will your order\n be shipped",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    letterSpacing: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter state';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'State',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter city';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'please enter locality';
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Locality',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: InkWell(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              print('valid');
            } else {
              print('not valid');
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF3854EE),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Save',
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
