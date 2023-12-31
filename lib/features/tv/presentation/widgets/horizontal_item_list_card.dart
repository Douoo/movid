import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/urls.dart';

import '../../domain/entites/series.dart';
import '../provider/series_list_provider.dart';
import '../widgets/minimal_detail.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalItemList extends StatelessWidget {
  final List<Tv> tvSeries;
  final bool isTopRated;

  const HorizontalItemList(
      {super.key, required this.tvSeries, required this.isTopRated});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<TvListProvider>(context, listen: false);
    return SizedBox(
      height: 175,
      child: NotificationListener(
        onNotification: (onScrollNotification) {
          if (onScrollNotification is ScrollEndNotification) {
            final before = onScrollNotification.metrics.extentBefore;
            final max = onScrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              if (isTopRated) {
                movieProvider.fetchTopRatedTv();
              }

              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: tvSeries.length,
            itemBuilder: (context, index) {
              final tv = tvSeries[index];
              return Container(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return MinimalDetail(
                            tv: tv,
                          );
                        });
                  },
                  child: CachedNetworkImage(
                    width: 125,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 170,
                        width: 125,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.fill, image: imageProvider),
                        ),
                      );
                    },
                    imageUrl: Urls.imageUrl(tvSeries[index].poster ?? ''),
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: const SizedBox(
                            height: 170,
                            width: 120,
                          ));
                    },
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
