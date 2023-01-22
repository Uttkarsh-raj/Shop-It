import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/screens/product_details.dart';
import 'package:store_api_flutter_course/services/api_handler.dart';
import 'package:store_api_flutter_course/widgets/feeds_widget.dart';

import '../models/product_model.dart';

class FeedsScreen extends StatefulWidget {
  FeedsScreen({super.key});
  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  List<ProductModel> productsList = [];

  Future<void> getProducts() async {
    productsList = await Api_handler.getAll();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    getProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: productsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              // shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0,
                childAspectRatio: 0.6,
              ),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: productsList[index],
                  child: const FeedsWidget(),
                );
              },
            ),
    );
  }
}
