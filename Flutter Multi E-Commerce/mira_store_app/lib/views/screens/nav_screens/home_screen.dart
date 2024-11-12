import 'package:flutter/material.dart';
import 'package:mira_store_app/views/screens/nav_screens/widgets/banner_widget.dart';
import 'package:mira_store_app/views/screens/nav_screens/widgets/category_item_widget.dart';
import 'package:mira_store_app/views/screens/nav_screens/widgets/header_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidgets(),
            BannerWidget(),
            CategoryItemWidgets(),
          ],
        ),
      ),
    );
  }
}
