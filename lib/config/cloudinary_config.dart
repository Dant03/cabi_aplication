import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryConfig extends StatefulWidget {
  @override
  _CloudinaryConfigState createState() => _CloudinaryConfigState();
}

class _CloudinaryConfigState extends State<CloudinaryConfig> {
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  Future<void> _pickAndUploadImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final String cloudinaryUrl = 'https://api.cloudinary.com/v1_1/YOUR_CLOUD_NAME/image/upload';
      final String uploadPreset = 'YOUR_UPLOAD_PRESET';

      final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl))
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);
        setState(() {
          _imageUrl = jsonResponse['secure_url'];
        });
        print('Image URL: $_imageUrl');
      } else {
        print('Image upload failed');
      }
    }
  }

  Future<void> _postImageUrlToApi() async {
    if (_imageUrl == null) return;

    final String apiUrl = 'https://yourapi.com/endpoint';
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'imageUrl': _imageUrl!,
      }),
    );

    if (response.statusCode == 200) {
      print('Image URL posted successfully');
    } else {
      print('Failed to post image URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickAndUploadImage,
              child: const Text('Pick & Upload Image'),
            ),
            const SizedBox(height: 20),
            _imageUrl != null
                ? Image.network(_imageUrl!)
                : const Text('No image uploaded'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _postImageUrlToApi,
              child: const Text('Post Image URL to API'),
            ),
          ],
        ),
      );
  }
}
