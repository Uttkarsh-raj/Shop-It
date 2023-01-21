import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:store_api_flutter_course/consts/api_consts.dart';

class Api_handler {
  static getAll() async {
    var uri = Uri.https(BASE_URL, "api/v1/products");
    var res = await http.get(uri);
    var data = jsonDecode(res.body);
    print(data);
  }
}
