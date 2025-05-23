import 'package:pharmacy_app/helpers/http_helper.dart';

class AuthService {
  static login(data) async => await HttpHelper.post('login', data);

  static signup(data) async => await HttpHelper.post('register', data);

  static logout() async => await HttpHelper.post('logout', {});

  static updateUser(data) async => await HttpHelper.put('user', data);

  static updateUserImage(image) async =>
      await HttpHelper.postMultipart('user/upload-icon', {}, image);

  static deleteUserById(data) async => await HttpHelper.delete('user');

  // static User get currentUser => User.fromJson(GetStorage().read('user'));

  // static bool get authenticated => GetStorage().read('token') != null;

  // static String get token => 'Bearer ${GetStorage().read('token')}';
}
