// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:admin_panel_app/controllers/banner_controller.dart';
import 'package:admin_panel_app/models/banner.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  // A Future that will hold the list of banners once loaded from the API
  late Future<List<BannerModel>> futureBanners;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Center(
            child: Text("Error ${snapshot.error}"),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Banners'),
          );
        } else {
          final banners = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: banners.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  width: 100,
                  height: 100,
                  banner.image,
                ),
              );
            },
          );
        }
      },
    );
  }
}
