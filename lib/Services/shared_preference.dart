import 'package:shared_preferences/shared_preferences.dart';

const userName = "name";

const userId = "user_id";

class SharedPrefResponse {
  static SharedPreferences? _prefns;
  static SharedPrefResponse? _instance;

  SharedPrefResponse._(SharedPreferences prefs) {
    _prefns = prefs;
  }

  static Future<void> initialize() async {
    _instance ??= SharedPrefResponse._(await SharedPreferences.getInstance());
  }

  static SharedPrefResponse get instance => _instance!;

  void setLoginDetails(String name, String id) {
    _prefns!.setString(userName, name);
    _prefns!.setString(userId, id);
  }

  void signOut() {
    _prefns!.clear();
  }

  String get usersName {
    return _prefns!.getString(userName)!;
  }

  String get usersID {
    return _prefns!.getString(userId)!;
  }
}
