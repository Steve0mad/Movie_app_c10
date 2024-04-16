import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlayTrailerWidget extends StatelessWidget {
  const PlayTrailerWidget({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: imagePath,
            fit: BoxFit.cover,
          ),
        ),
        Image.asset('assets/icons/ic-play.png'),
      ],
    );
  }
}
