import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/presentation/pages/popular_series_page.dart';
import 'package:movid/features/series/presentation/pages/top_rated_series_page.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:movid/features/series/presentation/provider/series_images_provider.dart';
import 'package:movid/features/series/presentation/provider/series_list_provider.dart';
import 'package:movid/features/series/presentation/widgets/vertical_item_list_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/loading_widget.dart';
import '../widgets/minimal_detail.dart';
import '../widgets/sub_heading.dart';

class MainSeriesPage extends StatefulWidget {
  const MainSeriesPage({super.key});

  @override
  State<MainSeriesPage> createState() => _MainSeriesPageState();
}

class _MainSeriesPageState extends State<MainSeriesPage> {
  @override
  void initState() {
    final tvProvider =
        Provider.of<TvSeriesListProvider>(context, listen: false);

    Future.microtask(() {
      tvProvider.fetchOnAirTvs().whenComplete(() {
        Provider.of<TvSeriesImagesProvider>(context, listen: false)
            .fetchSeriesImages(tvProvider.onAirTvs[0].id!);
        Provider.of<TvSeriesDetailProvider>(context, listen: false)
            .fetchDetailTvSeries(tvProvider.onAirTvs[0].id!);
      });

      tvProvider.fetchPopularSeries();
      tvProvider.fetchTopRatedSeries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        key: const Key('tvScrollView'),
        child: Column(
          children: [
            Consumer<TvSeriesListProvider>(
              builder: (context, data, child) {
                if (data.onAirTvsState == RequestState.loaded) {
                  return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 575.0,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 8),
                        autoPlayAnimationDuration: const Duration(seconds: 2),
                        onPageChanged: (index, reason) {
                          Provider.of<TvSeriesImagesProvider>(context,
                                  listen: false)
                              .fetchSeriesImages(data.onAirTvs[index].id!);
                          Provider.of<TvSeriesDetailProvider>(context,
                                  listen: false)
                              .fetchDetailTvSeries(data.onAirTvs[index].id!);
                        },
                      ),
                      items: data.onAirTvs.map((tv) {
                        return GestureDetector(
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
                              },
                            );
                          },
                          child: Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (rect) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black,
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    stops: [0, 0.3, 0.5, 1],
                                  ).createShader(
                                    Rect.fromLTRB(
                                      0,
                                      0,
                                      rect.width,
                                      rect.height,
                                    ),
                                  );
                                },
                                blendMode: BlendMode.dstIn,
                                child: CachedNetworkImage(
                                  height: 560.0,
                                  width: double.infinity,
                                  imageUrl: Urls.imageUrl(
                                      tv.poster ?? tv.backdropPath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Consumer<TvSeriesImagesProvider>(
                                    builder: (context, data, child) {
                                      if (data.state == RequestState.loaded) {
                                        if (data
                                            .mediaImages.posterPaths.isEmpty) {
                                          return const SizedBox();
                                        }
                                        return CachedNetworkImage(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          imageUrl: Urls.imageUrl(
                                            data.mediaImages.posterPaths[0],
                                          ),
                                        );
                                      } else if (data.state ==
                                          RequestState.error) {
                                        return const Center(
                                          child: Text('Load data failed'),
                                        );
                                      } else {
                                        return const Center(
                                          child: SizedBox(
                                              width: 50,
                                              child: LinearProgressIndicator()),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
                return ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0, 0.3, 0.5, 1],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[850]!,
                    highlightColor: Colors.grey[800]!,
                    child: Container(
                      height: 575.0,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black,
                    ),
                  ),
                );
              },
            ),
            SubHeading(
              valueKey: 'seePopulartvs',
              text: 'Popular',
              onSeeMoreTapped: () {
                Navigator.pushNamed(context, PopularSeriesPage.route);
              },
            ),
            Consumer<TvSeriesListProvider>(builder: (context, data, _) {
              if (data.popularTvsState == RequestState.loaded ||
                  data.popularTvs.isNotEmpty) {
                return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: VerticalItemList(
                      series: data.popularTvs,
                      isTopRated: false,
                    ));
              } else if (data.popularTvsState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return const LoadingWidget();
              }
            }),
            SubHeading(
              valueKey: 'seeTopRatedtvs',
              text: 'Top rated',
              onSeeMoreTapped: () {
                Navigator.pushNamed(context, TopRatedSeriesPage.route);
              },
            ),
            Consumer<TvSeriesListProvider>(builder: (context, data, _) {
              if (data.topRatedTvsState == RequestState.loaded ||
                  data.topRatedTvs.isNotEmpty) {
                return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: VerticalItemList(
                      series: data.topRatedTvs,
                      isTopRated: true,
                    ));
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _drawGeners(SeriesDetail series) {
    List<Widget> genreWidget = [];
    for (int i = 0; i < series.genres.length - 1; i++) {
      genreWidget.add(Text(series.genres[i].name));
      genreWidget.add(const SizedBox(
        width: 5,
      ));
    }
    return Row(
      children: genreWidget,
    );
  }
}
