import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/consts/api_consts.dart';
import 'package:store_api_flutter_course/models/category_model.dart';
import 'package:store_api_flutter_course/models/product_model.dart';
import 'package:store_api_flutter_course/models/users_model.dart';

class Api_handler {
  static Future<List<dynamic>> getData({required String target}) async {
    var uri = Uri.https(BASE_URL, "api/v1/$target");
    var res = await http.get(uri);
    var data = jsonDecode(res.body);
    List tempList = [];
    for (var v in data) {
      tempList.add(v);
    }
    // print(data);
    return tempList;
  }

  static Future<List<ProductModel>> getAll() async {
    List temp = await getData(target: "products");
    // print(data);
    return ProductModel.productsFromSnapshot(temp);
  }

  static Future<List<CategoryModel>> getAllCategories() async {
    List temp = await getData(target: "categories");
    // print(data);
    return CategoryModel.categoryFromSnapshot(temp);
  }

  static Future<List<UsersModel>> getAllUsers() async {
    List temp = await getData(target: "users");
    // print(data);
    return UsersModel.userFromSnapshot(temp);
  }
}
