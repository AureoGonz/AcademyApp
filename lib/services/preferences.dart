import 'package:academyapp/entities/k_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static Future<void> setLoginFields(String email, String password) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(KeyPReferencias.userEmail, email);
    sp.setString(KeyPReferencias.userPassword, password);
  }

  static Future<List> loadLoginFields() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return [sp.getString(KeyPReferencias.userEmail) ?? '', sp.getString(KeyPReferencias.userPassword) ?? ''];
  }

  static Future<String> loadEmailUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(KeyPReferencias.userEmail) ?? '';
  }

  static Future<String> loadPassUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(KeyPReferencias.userPassword) ?? '';
  }

  static Future<int> loadThemeApp() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(KeyPReferencias.appTheme) ?? 0;
  }

  static Future<void> setThemeApp(int tema) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setInt(KeyPReferencias.appTheme, tema);
  }
}