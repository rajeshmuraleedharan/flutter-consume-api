import 'package:consume_rest_api/models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/item.dart';
import 'package:get_it/get_it.dart';

class ItemsService {
  final headers = {'Content-Type': 'application/json'};
  final apiUrl = "http://192.168.1.14:5001/api";

  Future<APIResponse<List<Item>>> getItemsList() async {
    final getApiUrl = "$apiUrl/Items";
    var response = await http.get(getApiUrl, headers: headers);

    try {
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        final items =
            (jsonResponse as List).map((i) => Item.fromJson(i)).toList();

        return APIResponse<List<Item>>(data: items);
      }

      return APIResponse<List<Item>>(
          error: true, errorMessage: 'An error occured');
    } catch (error) {
      return APIResponse<List<Item>>(
          error: true, errorMessage: 'An error occured');
    }
  }

  Future<APIResponse<bool>> addItem(Item newItem) async {
    final postApiUrl = "$apiUrl/Items";
    var response = await http.post(postApiUrl,
        body: convert.json.encode(newItem.toJson()), headers: headers);

    return handleApiResponse<bool>(true, response.statusCode);
  }

  Future<APIResponse<bool>> deleteItem(Item item) async {
    final deleteApiUrl = "$apiUrl/Items/${item.id}";
    var response = await http.delete(deleteApiUrl, headers: headers);

    return handleApiResponse<bool>(true, response.statusCode);
  }

  Future<APIResponse<bool>> updateItem(Item item) async {
    final updateApiUrl = "$apiUrl/Items/${item.id}";
    var response = await http.put(updateApiUrl,
        body: convert.json.encode(item.toJson()), headers: headers);

    return handleApiResponse<bool>(true, response.statusCode);
  }

  Future<APIResponse<bool>> removeAllItems() async {
    final updateApiUrl = "$apiUrl/Items/clear";
    var response = await http.get(updateApiUrl, headers: headers);

    return handleApiResponse<bool>(true, response.statusCode);
  }

  APIResponse<T> handleApiResponse<T>(T data, int apiStatusCode,
      {int expectedStatuCode = 200}) {
    try {
      if (apiStatusCode == expectedStatuCode) {
        return APIResponse<T>(data: data);
      }
      return APIResponse<T>(error: true, errorMessage: 'An error occured');
    } catch (error) {
      return APIResponse<T>(error: true, errorMessage: 'An error occured');
    }
  }

  static ItemsService get itemService => GetIt.I<ItemsService>();
}
