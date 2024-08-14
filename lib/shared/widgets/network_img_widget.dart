import 'package:flutter/material.dart';

class NetworkImgWidget extends StatelessWidget {
  final String? urlImg;
  const NetworkImgWidget({super.key, required this.urlImg});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      placeholder: const AssetImage('assets/gifs/loading_1.gif'),
      image: NetworkImage(urlImg ?? ''),
      imageErrorBuilder: (c, o, s) =>
          Image.asset('assets/img/bg-no-photo-nbg.jpg'),
    );
  }
}
