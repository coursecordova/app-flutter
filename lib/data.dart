import 'package:shared_preferences/shared_preferences.dart';
class Userpref{
  static SharedPreferences? _preferences;
  static const _key = 'key';

  static Future init() async =>
  _preferences = await SharedPreferences.getInstance();


  static Future setNilai(bool nilai) async =>
  await _preferences!.setBool(_key, nilai);

  static bool? getNilai() => _preferences!.getBool(_key);
}