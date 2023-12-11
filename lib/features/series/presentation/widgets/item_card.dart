import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/presentation/pages/detail_tv_series_page.dart';

import '../../domain/entites/series.dart';

class ItemCard extends StatelessWidget {
  final TvSeries item;

  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailSeriesPage(
              seriesId: item.id,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(right: 8.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Color(0xFF14141C),
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
                    item.backdropPath ?? '',
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
                    item.title!,
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
                        '${(item.language ?? '').toUpperCase()} | ${item.date}',
                      ),
                      const SizedBox(width: 16.0),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        (item.rating! / 2).toStringAsFixed(1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    item.description ?? '-',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
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
