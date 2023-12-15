import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/styles/colors.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/presentation/pages/detail_tv_series_page.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

class TvDetailCard extends StatelessWidget {
  final Tv tv;
  const TvDetailCard({required this.tv, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: Column(
          children: [
            const SizedBox(
                width: 30,
                height: 10,
                child: Divider(
                  thickness: 3,
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 200,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill, image: imageProvider),
                        ),
                      );
                    },
                    imageUrl: Urls.imageUrl(tv.poster ?? ''),
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: const SizedBox(
                            height: 205,
                            width: 155,
                          ));
                    },
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              tv.title!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: primaryColor,
                                size: 15,
                              ),
                              const SizedBox(width: 3),
                              Text(tv.rating.toString().substring(0, 3))
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${tv.language!.toUpperCase()} | ${tv.date}",
                        style: const TextStyle(fontWeight: FontWeight.w200),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${tv.description!}...",
                        style: const TextStyle(
                            fontSize: 12.0, fontWeight: FontWeight.w300),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 12.0),
                      ElevatedButton(
                          onPressed: () {
                            final tvDetailProvider =
                                Provider.of<TvDetailProvider>(context,
                                    listen: false);
                            tvDetailProvider.fetchDetailTvSeries(tv.id!);
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailTvPage(tvId: tv.id)));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: kWhiteColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Text('CHECK IT OUT'))
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
