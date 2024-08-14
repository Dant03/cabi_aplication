import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryConfig extends StatefulWidget {
  const CloudinaryConfig({super.key});

  @override
  CloudinaryConfigState createState() => CloudinaryConfigState();
}

class CloudinaryConfigState extends State<CloudinaryConfig> {
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  Future<void> pickAndUploadImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      const String cloudinaryUrl =
          'https://api.cloudinary.com/v1_1/dpoosdwgu/image/upload';
      const String uploadPreset =
          'system_uploader_1e2ddab171f769b9_c872b1db33094e851af414d8c0526278b7';

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'upload_preset': uploadPreset,
      });

      final dio = Dio();

      final response = await dio.post(cloudinaryUrl, data: formData);

      if (response.statusCode == 200) {
        setState(() {
          _imageUrl = response.data['secure_url'];
        });
        print('Image URL: $_imageUrl');
        // return _imageUrl;
      } else {
        print('Image upload failed: ${response.statusCode}');
        // return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: pickAndUploadImage,
            child: const Text('Subir imagen'),
          ),
          const SizedBox(height: 20),
          _imageUrl != null
              ? Image.network(_imageUrl!)
              : const Text('Sin imagen'),
        ],
      ),
    );
  }
}
