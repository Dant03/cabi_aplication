import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/user.dart';

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
    validateStatus: (status) => true,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    baseUrl: dotenv.env['BASE_URL']!)));

final storage = FlutterSecureStorage();

final authProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(dio);
});

class AuthService {
  final Dio dio;
  AuthService(this.dio);

  Future<User?> login(String email, String password) async {
    final response = await dio.post('/users', data: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      final user = User.fromJson(response.data['user']);
      await storage.write(key: 'token', value: response.data['token']);
      return user;
    }
    return null;
  }

  Future<User?> register(User user) async {
    final response = await dio.post('/users', data: user.toJson());
    print("auth_provider: ${user.toJson()}");
    if (response.statusCode == 201) {
      final newUser = User.fromJson(response.data['user']);
      await storage.write(key: 'token', value: response.data['token']);
      return newUser;
    }
    return null;
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
