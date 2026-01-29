import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  Future setUserId(String uuid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uuid', uuid);
  }

  Future setOnboardingStatus(bool status) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingStatus', status);
  }

  Future setUserEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('uuid');
  }

  Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<bool> getOnboardingStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingStatus') ?? false;
  }
}
