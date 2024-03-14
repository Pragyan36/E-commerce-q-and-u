import 'package:get_storage/get_storage.dart';

class AppStorage {
  static GetStorage? storage = GetStorage('User');

  static const String keyAccessToken = 'token';
  static const String email = 'email';
  static const String password = 'password';
  static const String isloggedin = 'isloggedin';
  static const String isStaffloggedin = 'isStaffloggedin';
  static const String userId = 'userId';
  static const String rememberMe = 'rememberMe';
  static const String rememberPassword = 'passwordRemember';
  static const String emailRemember = 'emailRemember';

////////////////////functions to write data/////////////////////////////

  static void saveAccessToken(dynamic value) {
    AppStorage.storage?.write(keyAccessToken, value);
  }

  static void saveIsLoggedin(dynamic value) {
    AppStorage.storage?.write(isloggedin, value);
  }

  static void saveIsStaffLoggedin(dynamic value) {
    print("isStaffloggedin $value");
    AppStorage.storage?.write(isStaffloggedin, value);
  }

  static void saveEmail(dynamic value) {
    AppStorage.storage?.write(email, value);
  }

  static void savePassword(dynamic value) {
    print("saved password $value");
    AppStorage.storage?.write(password, value);
  }

  static void saveUserId(dynamic value) {
    AppStorage.storage?.write(userId, value);
  }

  static void saveRememberme(dynamic value) {
    AppStorage.storage?.write(rememberMe, value);
  }

  static void saveRememberPassword(dynamic value) {
    AppStorage.storage?.write(rememberPassword, value);
  }

  static void saveRememberEmail(dynamic value) {
    AppStorage.storage?.write(emailRemember, value);
  }

  ////////////////////Function to read data/////////////////////////////

  static String? get readAccessToken {
    return storage?.read(keyAccessToken);
  }

  static bool? get readIsLoggedIn {
    return storage?.read(isloggedin);
  }

  static bool? get readIsStaffLoggedIn {
    print("isStaffloggedin $isStaffloggedin");
    return storage?.read(isStaffloggedin);
  }

  static String? get readEmail {
    return storage?.read(email);
  }

  static String? get readPassword {
    return storage?.read(password);
  }

  static String? get readUserId {
    return storage?.read(userId);
  }

  static bool? get readRememberme {
    return storage?.read(rememberMe);
  }

  static bool? get readRemberPassword {
    return storage?.read(rememberPassword);
  }

  static bool? get readRemberEmail {
    return storage?.read(emailRemember);
  }

  ////////////////////Function to remove data/////////////////////////////
  static void removeStorage() {
    AppStorage.storage?.remove(keyAccessToken);
    AppStorage.storage?.remove(isloggedin);
    AppStorage.storage?.remove(isStaffloggedin);
    // AppStorage.storage?.remove(email);
    // AppStorage.storage?.remove(password);
    AppStorage.storage?.remove(userId);
    // AppStorage.storage?.remove(rememberMe);
  }
}
