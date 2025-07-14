import 'package:pharmacy_app/helpers/http_helper.dart';
import 'package:get_storage/get_storage.dart';

class AuthService {
  static final _storage = GetStorage();

  static Future<Map<String, dynamic>?> login(Map<String, dynamic> data) async {
    print('object');
    try {
      print('object1');
      final response = await HttpHelper.post('Account/login', data);
      print('response: $response');
      print('object2');
      if (response != null && response['token'] != null) {
        await _storage.write('token', response['token']);
        print('تم تسجيل الدخول');
        print('object3');
      }
      print('object4');
      return response;
    } catch (e) {
      return null;
    }
  }

  static signup(data) async => await HttpHelper.post('register', data);

  static logout() async {
    await _storage.remove('token');
    return await HttpHelper.post('logout', {});
  }

  static updateUser(data) async => await HttpHelper.put('user', data);

  static updateUserImage(image) async =>
      await HttpHelper.postMultipart('user/upload-icon', {}, image);

  static deleteUserById(data) async => await HttpHelper.delete('user');

  // static User get currentUser => User.fromJson(GetStorage().read('user'));

  // static bool get authenticated => GetStorage().read('token') != null;

  // static String get token => 'Bearer ${GetStorage().read('token')}';
}
