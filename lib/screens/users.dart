import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_api_flutter_course/models/users_model.dart';
import 'package:store_api_flutter_course/widgets/category_widget.dart';
import 'package:store_api_flutter_course/widgets/users_widget.dart';

import '../models/category_model.dart';
import '../services/api_handler.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<UsersModel>>(
        future: Api_handler.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occured ${snapshot.error}'),
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: Text('No items found..!!'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const UsersWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
