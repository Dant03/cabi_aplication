// import 'package:get/get.dart';

// class ApiConfig extends GetConnect {
//   final isLoading = false.obs;
//   @override
//   void onReady() {
//     // httpClient.baseUrl = 'http://192.168.3.42:3000/api/v1';
//     httpClient.baseUrl = 'http://localhost:3000/api/v1';
//     super.onReady();
//   }
// }


import 'package:dio/dio.dart';

final dio = Dio(BaseOptions(
  baseUrl: 'http://192.168.1.37:3000/api/v1',
  validateStatus: (status) =>  status! < 500,
));
