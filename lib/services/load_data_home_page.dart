import 'dart:convert';

import 'package:logafic/data_model/content_model.dart';
import 'package:logafic/data_model/model.dart';
import 'package:http/http.dart' as http;

String _baseUrl = "http://localhost:3000";
Future<DataModel?> loadData(List<ContentModel>? data) async {
  try {
    await new Future.delayed(const Duration(seconds: 1));
    var url = Uri.https("$_baseUrl", '/user');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      List<dynamic> dataBody = jsonDecode(res.body);
      data = data! +
          dataBody.map((dynamic e) => ContentModel.fromJson(e)).toList();
    }
  } catch (err) {
    print(err);
  }
}
