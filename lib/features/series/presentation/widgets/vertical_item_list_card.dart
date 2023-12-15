import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/domain/entites/series.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:movid/features/series/presentation/provider/series_list_provider.dart';
import 'package:movid/features/series/presentation/widgets/series_detail_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class VerticalItemList extends StatelessWidget {
  final List<Tv> tvSeries;
  final bool isTopRated;

  const VerticalItemList(
      {super.key, required this.tvSeries, required this.isTopRated});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<TvListProvider>(context, listen: false);
    return SizedBox(
      height: 205,
      child: NotificationListener(
        onNotification: (_onScrollNotification) {
          if (_onScrollNotification is ScrollEndNotification) {
            final before = _onScrollNotification.metrics.extentBefore;
            final max = _onScrollNotification.metrics.maxScrollExtent;
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
                    final tvDetailProvider =
                        Provider.of<TvDetailProvider>(context, listen: false);
                    tvDetailProvider.fetchDetailTvSeries(tv.id!);
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return TvDetailCard(tv: tv);
                        });
                  },
                  child: SizedBox(
                    width: 125,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          width: 125,
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
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          tvSeries[index].title ?? "",
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: Text(
                          "${tvSeries[index].date!.substring(0, 4)} - ${tvSeries[index].rating!.toStringAsFixed(1)}",
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
