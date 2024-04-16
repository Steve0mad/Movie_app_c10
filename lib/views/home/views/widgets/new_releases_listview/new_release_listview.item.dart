import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movies/components/models/results_model.dart';
import 'package:movies/components/my_provider.dart';

class NewReleaseListViewItem extends StatefulWidget {
  const NewReleaseListViewItem({
    super.key,
    required this.imagePath,
    required this.movie,
  });

  final String imagePath;

  final Results movie;

  @override
  State<NewReleaseListViewItem> createState() => _NewReleaseListViewItemState();
}

class _NewReleaseListViewItemState extends State<NewReleaseListViewItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
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
          ),
          GestureDetector(
            onTap: () {
              isClicked = !isClicked;
              Provider.of<MyProvider>(context, listen: false)
                  .addToFavorite(widget.movie);
              setState(() {});
            },
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.only(topLeft: Radius.circular(12)),
              child: Image.asset(
                isClicked
                    ? 'assets/icons/ic-clicked-bookmark.png'
                    : 'assets/icons/ic-bookmark.png',
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
