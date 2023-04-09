import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesController {
  // make default constructor private
  SharedPreferencesController._() {
    initSharedPreferences();
  }

  static SharedPreferencesController? _instance;
  late SharedPreferences _sharedPreferences;

  static SharedPreferencesController? get getInstance {
    _instance ?? (_instance = SharedPreferencesController._());
    return _instance;
  }

  Future initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
