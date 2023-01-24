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
  final ScrollController scrollController = ScrollController();
  List<ProductModel> productsList = [];
  int limit = 10;
  bool _isLoading = false;
  bool _isLimit = false;

  Future<void> getProducts() async {
    productsList = await Api_handler.getAll(limit: limit.toString());
    setState(() {});
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _isLoading = true;
        limit += 10;
        if (limit == 200) {
          _isLimit = true;
        }
        await getProducts();
        // _isLoading = false;
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: productsList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                  if (!_isLimit)
                    const Center(child: CircularProgressIndicator())
                ],
              ),
            ),
    );
  }
}
