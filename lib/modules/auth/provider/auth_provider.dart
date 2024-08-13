import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/config/dio_config.dart';
import 'package:movil_cabi_app/modules/auth/models/login_request_model.dart';
import 'package:movil_cabi_app/modules/auth/models/login_response_model.dart';
import 'package:movil_cabi_app/modules/auth/models/register_request_model.dart';
import 'package:movil_cabi_app/modules/users/models/user_model.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class AuthProvider {
  static final isAuthenticated = StateProvider<bool>((ref) => false);
  static final userAuth = StateProvider<UserModel?>((ref) => UserModel());
  static final userCreated = StateProvider<UserModel?>((ref) => UserModel());

  static final onLogout = StateProvider((ref) {
    ref.read(isAuthenticated.notifier).update((s) => s = false);
    ref.read(userAuth.notifier).update((s) => s = null);
    ref.read(userCreated.notifier).update((s) => s = null);
  });

  static final postLoginProvider = FutureProvider.autoDispose
      .family<void, LoginRequestModel>((ref, loginDto) async {
    try {
      final response = await dio.post('/users/login', data: loginDto.toJson());

      if (response.statusCode != 200) {
        ref.read(isAuthenticated.notifier).update((s) => s = false);
        Get.snackbar(
          'Error en autenticación',
          '${response.data["message"]}',
          colorText: Colors.redAccent,
        );
        return;
      }

      ref.read(isAuthenticated.notifier).update((s) => s = true);
      ref
          .read(userAuth.notifier)
          .update((s) => s = LoginResponseModel.fromJson(response.data).user!);

      Get.offAllNamed(AppRoutes.tournament);
      return;
    } catch (e) {
      ref.read(isAuthenticated.notifier).update((s) => s = false);
    }
  });

  static final postRegisterProvider = FutureProvider.autoDispose
      .family<void, RegisterRequestModel>((ref, user) async {
    try {
      final response = await dio.post('/users', data: {
        "user_first_name": user.userFirstName,
        "user_last_name": user.userLastName,
        "user_email": user.userEmail,
        "user_password": user.userPassword,
      });

      if (response.statusCode == 201) {
        Get.snackbar('Muy bien', 'Usuario creado con éxito');
        ref.read(userCreated.notifier).update((s) => s = response.data);
        Get.toNamed(AppRoutes.login);
      } else {
        Get.snackbar('No se pudo crear usuario', '${response.data["message"]}');
      }

      ref.read(isAuthenticated.notifier).update((s) => s = true);
      ref
          .read(userAuth.notifier)
          .update((s) => s = LoginResponseModel.fromJson(response.data).user!);
      return;
    } catch (e) {
      return;
    }
  });
}
