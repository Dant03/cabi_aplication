import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

void main() {

  // Inicializacion

  runApp(
    ProviderScope(
      child: GetMaterialApp(
        getPages: listPageConfig,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
