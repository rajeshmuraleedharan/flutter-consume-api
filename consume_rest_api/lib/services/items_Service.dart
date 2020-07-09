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

    try {
      if (response.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    } catch (error) {
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }
  }

  static ItemsService get itemService => GetIt.I<ItemsService>();
}
