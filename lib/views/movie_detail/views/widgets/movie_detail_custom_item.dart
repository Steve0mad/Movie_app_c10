import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MvovieDetailCustomItem extends StatefulWidget {
  const MvovieDetailCustomItem({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  State<MvovieDetailCustomItem> createState() => _MvovieDetailCustomItemState();
}

class _MvovieDetailCustomItemState extends State<MvovieDetailCustomItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: widget.imagePath,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
