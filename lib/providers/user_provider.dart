import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart'; // Ajusta la ruta según tu proyecto
import '/models/user.dart';

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
    validateStatus: (status) => true,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    baseUrl: dotenv.env['BASE_URL']!)));

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(ref);
});

final registerProvider = FutureProvider.family<User?, User>((ref, user) async {
  final dio = ref.watch(dioProvider);
  print("En el provider: ${user.toJson()}");
  final response = await dio.post<User>('/users', data: {
    "name": user.name,
    "last_name": user.lastName,
    "email": user.email,
    "password": user.password,
  });
  print("respuesta del back: ${response.data}");
  if (response.statusCode != 201) {
    throw Exception('Failed to create tournament');
  }
  return response.data;
});

class UserNotifier extends StateNotifier<User?> {
  final Ref ref;

  UserNotifier(this.ref) : super(null);

  Future<void> login(String email, String password) async {
    final authService = ref.watch(authProvider);
    final user = await authService.login(email, password);
    state = user;
  }

  Future<void> register(User user) async {
    print(user.toJson());
    // final authService = ref.watch(authProvider);
    // final newUser = await authService.register(user);
    // state = newUser;
    // print(newUser);
    final dio = ref.watch(dioProvider);
    print("En el provider: ${user.toJson()}");
    final response = await dio.post('/users', data: {
      // "user_id": user.userId,
      "name": user.name,
      "last_name": user.lastName,
      "email": user.email,
      "password": user.password,
      "role": user.role,
      "status": user.status,
    });
    print("respuesta del back: ${response.data}");
    if (response.statusCode != 201) {
      throw Exception('Failed to create tournament');
    }
  }

  //

  final createUserProvider =
      FutureProvider.family<User, User>((ref, user) async {
    final dio = ref.watch(dioProvider);
    print("En el provider: ${user.toJson()}");
    final response = await dio.post('/users', data: {
      "user_id": user.userId,
      "name": user.name,
      "last_name": user.lastName,
      "email": user.email,
      "password": user.password,
      "role": user.role,
      "status": user.status,
    });
    print("respuesta del back: ${response.data}");
    if (response.statusCode != 201) {
      throw Exception('Failed to create tournament');
    }
    //   return Tournament(
    //       tournamentId: 0,
    //       name: "",
    //       image: '',
    //       location: '',
    //       numCourts: 1,
    //       registrationDate: '',
    //       startDate: '',
    //       gameDays: [],
    //       registrationValue: 0,
    //       warrantyValue: 0,
    //       matchValue: 0,
    //       rules: '',
    //       phone: '',
    //       email: '',
    //       status: '',
    //       categories: []);
    // }

    return response.data!;
  });
  //

  Future<void> logout() async {
    final authService = ref.watch(authProvider);
    await authService.logout();
    state = null;
  }

  Future<void> checkAuthStatus() async {
    final authService = ref.watch(authProvider);
    final token = await authService.getToken();
    if (token != null) {
      // Simulamos obtener el usuario con el token
      state = User(
        userId: 1,
        name: 'Sample',
        lastName: 'User',
        email: 'sample@example.com',
        password: '',
        role: 'user',
        status: 'active',
      );
    }
  }
}
