import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsStartup {
  int startupCount = 0;
  String startupCountKey = "startup_count";
  late SharedPreferences startupSharedPrefs;

  void initStartupSharedPrefs() async {
    startupSharedPrefs = await SharedPreferences.getInstance();
  }

  void increaseStartupCount() {
    startupCount++;
    _saveStartupCount();
  }

  void _saveStartupCount() async {
    startupSharedPrefs.setInt(startupCountKey, startupCount);
  }

  void getStartupCount() async {
    startupSharedPrefs.getInt(startupCountKey);
  }

  bool isFirstTime() {
    getStartupCount();
    if (startupCount > 0) {
      return false;
    } else {
      return true;
    }
  }
}
