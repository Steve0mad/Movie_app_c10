import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:movies/components/models/results_model.dart';
import 'package:movies/components/my_provider.dart';
import 'package:provider/provider.dart';

class RecomendedMoviesListViewItem extends StatefulWidget {
  const RecomendedMoviesListViewItem(
      {super.key, required this.imagePath, required this.movie});

  final String imagePath;
  final Results movie;

  @override
  State<RecomendedMoviesListViewItem> createState() =>
      _RecomendedMoviesListViewItemState();
}

class _RecomendedMoviesListViewItemState
    extends State<RecomendedMoviesListViewItem> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: CachedNetworkImage(
              imageUrl: widget.imagePath,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
              height: 130,
              width: 130,
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
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(12)),
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
    );
  }
}
