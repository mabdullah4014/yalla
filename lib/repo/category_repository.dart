import 'dart:convert';
import 'package:arbi/model/category_response.dart';
import 'package:arbi/utils/helper.dart';
import 'package:flutter/services.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

Future<Stream<Category>> getCategories() async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}categories';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .expand((data) => (data as List))
      .map((data) => Category.fromJson(data));
}

Future<Stream<Category>> getCategoriesDump() async {
  String jsonString = await _loadFromAsset();
  final jsonResponse = jsonDecode(jsonString);
  CategoryResponse categoryResponse = CategoryResponse.fromJson(jsonResponse);
  return Stream.fromIterable(categoryResponse.data);
}

Future<String> _loadFromAsset() async {
  return await rootBundle.loadString("assets/cfg/categories.json");
}

/*Future<Stream<Category>> getCategory(String id) async {
  final String url =
      '${GlobalConfiguration().getString('api_base_url')}categories/$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .map((data) => Helper.getData(data))
      .map((data) => Category.fromJSON(data));
}*/
