import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/presentation/provider/series_list_provider.dart';
import 'package:movid/features/series/presentation/widgets/series_detail_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class VerticalItemList extends StatelessWidget {
  final List<TvSeries> series;
  final bool isTopRated;

  const VerticalItemList(
      {super.key, required this.series, required this.isTopRated});

  @override
  Widget build(BuildContext context) {
    final movieProvider =
        Provider.of<TvSeriesListProvider>(context, listen: false);
    return SizedBox(
      height: 290,
      child: NotificationListener(
        onNotification: (_onScrollNotification) {
          if (_onScrollNotification is ScrollEndNotification) {
            final before = _onScrollNotification.metrics.extentBefore;
            final max = _onScrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              if (isTopRated) {
                movieProvider.fetchTopRatedSeries();
              }
              movieProvider.fetchPopularSeries();
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
            itemCount: series.length,
            itemBuilder: (context, index) {
              final tvSeries = series[index];
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
                          return SeriesDetailCard(series: tvSeries);
                        });
                  },
                  child: SizedBox(
                    width: 155,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 205,
                              width: 155,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.fill, image: imageProvider),
                              ),
                            );
                          },
                          imageUrl: Urls.imageUrl(series[index].poster ?? ''),
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          series[index].title ?? "",
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: Text(
                          "${series[index].date!.substring(0, 4)} - ${series[index].rating!.toStringAsFixed(1)}",
                          style: const TextStyle(fontWeight: FontWeight.w100),
                        )),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}