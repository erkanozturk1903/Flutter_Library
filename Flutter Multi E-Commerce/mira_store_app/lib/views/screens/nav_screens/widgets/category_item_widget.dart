import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mira_store_app/controllers/category_controller.dart';
import 'package:mira_store_app/provider/category_provider.dart';
import 'package:mira_store_app/views/screens/detail/screens/inner_category_screen.dart';
import 'package:mira_store_app/views/screens/nav_screens/widgets/reusable_text_widget.dart';

class CategoryItemWidgets extends ConsumerStatefulWidget {
  const CategoryItemWidgets({super.key});

  @override
  ConsumerState<CategoryItemWidgets> createState() =>
      _CategoryItemWidgetsState();
}

class _CategoryItemWidgetsState extends ConsumerState<CategoryItemWidgets> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    final CategoryController categoryController = CategoryController();
    try {
      final categories = await categoryController.loadCaategories();
      ref.read(categoryProvider.notifier).setCategories(categories);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(title: 'Categories', subTitle: 'View All'),
        GridView.builder(
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
        ),
      ],
    );
  }
}
