import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movil_cabi_app/config/dio_config.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class AuthController extends GetxController {
  final isLoggedIn = false.obs;
  
  Future onLogin(String email, String password) async {
    try {
      final response = await dio.post(
        '/users/login',
        data: {"email": email, "password": password},
      );
      
      if (response.statusCode == 200) {
        isLoggedIn.value = true;
        Get.offAllNamed(AppRoutes.tournament);
      } else {
        isLoggedIn.value = false;
        Get.snackbar(
          'Error en autenticación',
          response.data["message"].toString(),
          colorText: Colors.redAccent,
          overlayBlur: 20
        );
      }
    } catch (e) {
      Get.log(e.toString());
      Get.snackbar('Error en autenticación', e.toString());
    }
  }

  onLogout () {
    isLoggedIn.value = false;
    Get.offAllNamed(AppRoutes.login);

  }
}
