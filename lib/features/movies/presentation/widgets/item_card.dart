import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/movies/presentation/pages/movie_detail_page.dart';

import '../../domain/entities/movie.dart';

class ItemCard extends StatelessWidget {
  final Movie movie;

  const ItemCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(
              movieId: movie.id,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 8.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFF14141C),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
              // flex: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: Urls.imageUrl(
                    movie.posterPath ?? '',
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              // flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        '${(movie.language ?? '').toUpperCase()} | ${movie.releaseDate}',
                      ),
                      const SizedBox(width: 16.0),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        (movie.voteAverage! / 2).toStringAsFixed(1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    movie.overview ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
