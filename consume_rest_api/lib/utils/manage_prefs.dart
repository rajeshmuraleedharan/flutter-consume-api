import 'dart:convert';

import '../models/app_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManagePrefsUtil {
  static void saveToPrefs(AppState state) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var appStateJson = json.encode(state.toJson());

    await preferences.setString("appState", appStateJson);
  }

  static Future<AppState> loadFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var appStateJsonString = preferences.getString("appState");

    if (appStateJsonString != null) {
      return AppState.fromJson(json.decode(appStateJsonString));
    }

    return AppState.initialState();
  }
}
