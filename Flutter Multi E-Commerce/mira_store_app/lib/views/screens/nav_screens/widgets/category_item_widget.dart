import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mira_store_app/controllers/category_controller.dart';
import 'package:mira_store_app/models/category.dart';
import 'package:mira_store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:mira_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryItemWidgets extends StatefulWidget {
  const CategoryItemWidgets({super.key});

  @override
  State<CategoryItemWidgets> createState() => _CategoryItemWidgetsState();
}

class _CategoryItemWidgetsState extends State<CategoryItemWidgets> {
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCaategories();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(
          title: "Categories",
          subTitle: "View All",
        ),
        FutureBuilder(
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
                child: Text('No Categories'),
              );
            } else {
              final categories = snapshot.data!;
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InnerCategoryScreen(
                            category: category,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.network(
                          category.image,
                          height: 47,
                          width: 47,
                        ),
                        Text(
                          category.name,
                          style: GoogleFonts.quicksand(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}
