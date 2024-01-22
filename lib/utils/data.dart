import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Userpref {
  static SharedPreferences? _preferences;
  static const _key = 'key';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future deleteData(String keyData) async =>
      _preferences?.remove(keyData);

  static Future setNilai(bool nilai) async =>
      await _preferences!.setBool(_key, nilai);

  static Future setIsLogin(bool isLogin) async =>
      await _preferences!.setBool('home', isLogin);

  static Future setUserData(Map<String, dynamic> data) async =>
      await _preferences!.setString("userdata", jsonEncode(data));

  static Map<String, dynamic> getUserData() {
    try {
      String? userDataString = _preferences!.getString("userdata");

      if (userDataString != null) {
        // Parse string JSON menjadi Map
        Map<String, dynamic> userData = jsonDecode(userDataString);
        return userData;
      } else {
        // Jika tidak ada data, kembalikan Map kosong atau nilai default
        return {};
      }
    } catch (e) {
      print("Error decoding user data: $e");
      return {};
    }
  }

  static bool? getNilai() => _preferences!.getBool(_key);
}
