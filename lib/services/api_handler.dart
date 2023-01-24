import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/consts/api_consts.dart';
import 'package:store_api_flutter_course/models/category_model.dart';
import 'package:store_api_flutter_course/models/product_model.dart';
import 'package:store_api_flutter_course/models/users_model.dart';

class Api_handler {
  static Future<List<dynamic>> getData(
      {required String target, String? limit}) async {
    try {
      var uri = Uri.https(
          BASE_URL,
          "api/v1/$target",
          target == "products"
              ? {
                  "offset": "0",
                  "limit": limit,
                }
              : {});
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      List tempList = [];
      if (res.statusCode != 200) {
        throw data["message"];
      }
      for (var v in data) {
        tempList.add(v);
      }
      // print(data);
      return tempList;
    } catch (error) {
      log("An error occured $error.");
      throw error.toString();
    }
  }

  static Future<List<ProductModel>> getAll({required String limit}) async {
    List temp = await getData(target: "products", limit: limit);
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

  static Future<ProductModel> getProductsById({required String id}) async {
    try {
      var uri = Uri.https(BASE_URL, "api/v1/products/$id");
      var res = await http.get(uri);
      var data = jsonDecode(res.body);
      if (res.statusCode != 200) {
        throw data["message"];
      }
      return ProductModel.fromJson(data);
    } catch (error) {
      log("An error occured $error.");
      throw error.toString();
    }
  }
}
