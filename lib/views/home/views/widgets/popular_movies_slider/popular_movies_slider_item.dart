import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class PopularMoviesSliderItem extends StatelessWidget {
  const PopularMoviesSliderItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.releaseDate,
    required this.adultOrNot,
  });

  final String imagePath;
  final String title;
  final String releaseDate;
  final String adultOrNot;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: CachedNetworkImage(
            imageUrl: imagePath,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 30,
          bottom: 40,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                height: 250,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    // '${ApiConfig.imageBaseUrl}${data[index].posterPath}',
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          releaseDate,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          adultOrNot,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
