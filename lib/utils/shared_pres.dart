part of 'utils.dart';

class SharedPres {
  static SharedPreferences sharedPreferences;
  static SharedPres instance;

  static Future<void> prefsInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveUser(User user) async {
    await sharedPreferences.setString(Constants.sharePresUID, user.uID);
    await sharedPreferences.setString(Constants.sharePresName, user.name);
    await sharedPreferences.setString(Constants.sharePresEmail, user.email);
    await sharedPreferences.setString(Constants.sharePresAvatar, user.avatar);
  }

  static User getUser() {
    final uID = sharedPreferences.getString(Constants.sharePresUID);
    final name = sharedPreferences.getString(Constants.sharePresName);
    final userName = sharedPreferences.getString(Constants.sharePresEmail);
    final avatar = sharedPreferences.getString(Constants.sharePresAvatar);
    return User(uID: uID, name: name, email: userName, avatar: avatar);
  }

  Future<void> clearAll() async {
    await sharedPreferences.clear();
  }
}
