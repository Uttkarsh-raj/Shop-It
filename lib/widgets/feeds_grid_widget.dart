import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/models/product_model.dart';
import 'package:store_api_flutter_course/widgets/feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  const FeedsGridWidget({super.key, required this.productsList});
  final List<ProductModel> productsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        childAspectRatio: 0.6,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: productsList[index],
          child: const FeedsWidget(),
        );
      },
    );
  }
}
