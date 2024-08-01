import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart'; // Ajusta la ruta según tu proyecto
import '/models/user.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  return UserNotifier(ref);
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
    final authService = ref.watch(authProvider);
    final newUser = await authService.register(user);
    state = newUser;
    print(newUser);
  }

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
