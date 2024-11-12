import 'package:admin_panel_app/controllers/subcategory_controller.dart';
import 'package:admin_panel_app/models/subcategory.dart';
import 'package:flutter/material.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  late Future<List<Subcategory>> futureCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = SubcategoryController().loadSubcategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error ${snapshot.data}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Sub Categories'),
          );
        } else {
          final subcategories = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: subcategories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              return Column(
                children: [
                  Image.network(
                    subcategory.image,
                    height: 100,
                    width: 100,
                  ),
                  Text(subcategory.subCategoryName),
                ],
              );
            },
          );
        }
      },
    );
  }
}
