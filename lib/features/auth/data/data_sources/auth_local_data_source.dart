import 'package:hive/hive.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  UserModel? getUser(String email);
  Future<void> clearUser();
  UserModel? getLoggedUser();
  Future<void> setLoggedUser(String email);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> userBox;
  final Box settingsBox;

  AuthLocalDataSourceImpl(this.userBox, this.settingsBox);

  @override
  Future<void> cacheUser(UserModel user) async {
    await userBox.put(user.email, user);
  }

  @override
  UserModel? getUser(String email) {
    return userBox.get(email);
  }

  @override
  Future<void> clearUser() async {
    await settingsBox.delete('logged_user_email');
  }

  @override
  UserModel? getLoggedUser() {
    final email = settingsBox.get('logged_user_email');
    if (email != null) {
      return userBox.get(email);
    }
    return null;
  }

  @override
  Future<void> setLoggedUser(String email) async {
    await settingsBox.put('logged_user_email', email);
  }
}
