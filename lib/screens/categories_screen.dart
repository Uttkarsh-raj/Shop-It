import 'package:flutter/material.dart';
import 'package:store_api_flutter_course/widgets/category_widget.dart';

import '../widgets/feeds_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 1.2,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return const CategoryWidget();
        },
      ),
    );
  }
}
