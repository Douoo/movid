import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/core/utils/urls.dart';
import '../../domain/entites/series_detail.dart';
import 'popular_series_page.dart';
import 'top_rated_series_page.dart';
import '../provider/series_detail_provider.dart';
import '../provider/series_images_provider.dart';
import '../provider/series_list_provider.dart';
import '../widgets/horizontal_item_list_card.dart';

import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../movies/presentation/widgets/loading_widgets.dart';
import '../../../movies/presentation/widgets/sub_heading.dart';
import '../widgets/minimal_detail.dart';

class MainTvPage extends StatefulWidget {
  const MainTvPage({super.key});

  @override
  State<MainTvPage> createState() => _MainTvPageState();
}

class _MainTvPageState extends State<MainTvPage> {
  @override
  void initState() {
    final tvProvider = Provider.of<TvListProvider>(context, listen: false);

    Future.microtask(() {
      tvProvider.fetchOnAirTv().whenComplete(() {
        Provider.of<TvImagesProvider>(context, listen: false)
            .fetchtvImages(tvProvider.onAirTvs[0].id!);
        Provider.of<TvDetailProvider>(context, listen: false)
            .fetchDetailTvSeries(tvProvider.onAirTvs[0].id!);
      });

      tvProvider.fetchPopularTv(1);
      tvProvider.fetchTopRatedTv();
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
            Consumer<TvListProvider>(
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
                          Provider.of<TvImagesProvider>(context, listen: false)
                              .fetchtvImages(data.onAirTvs[index].id!);
                          Provider.of<TvDetailProvider>(context, listen: false)
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, left: 20),
                                child: Consumer<TvImagesProvider>(
                                  builder: (context, tvImageData, child) {
                                    if (tvImageData.state ==
                                        RequestState.loaded) {
                                      return Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        tv.title!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineMedium
                                                            ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                Consumer<TvDetailProvider>(
                                                  builder: (context, detailData,
                                                      child) {
                                                    if (detailData.state ==
                                                        RequestState.loaded) {
                                                      if (tv.rating != null &&
                                                          tv.rating! > 0) {
                                                        return Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.star),
                                                            const SizedBox(
                                                                width: 4),
                                                            Text(
                                                              tv.rating
                                                                  .toString()
                                                                  .substring(
                                                                      0, 3),
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                            ),
                                                            const SizedBox(
                                                                width: 8),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            _drawGenres(
                                                                detailData
                                                                    .tvDetail)
                                                          ],
                                                        );
                                                      }
                                                      return const SizedBox();
                                                    } else {
                                                      return const SizedBox();
                                                    }
                                                  },
                                                ),
                                                const SizedBox(height: 8),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        tv.description
                                                            .toString(),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]));

                                      
                                    } else if (tvImageData.state ==
                                        RequestState.error) {
                                      return const Center(
                                        child: Text('Load data failed'),
                                      );
                                    } else {
                                      return const Center(
                                        child: SizedBox(),
                                      );
                                    }
                                  },
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
                Navigator.pushNamed(context, PopularTvPage.route);
              },
            ),
            Consumer<TvListProvider>(builder: (context, data, _) {
              if (data.popularTvsState == RequestState.loaded ||
                  data.popularMovies.isNotEmpty) {
                return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: HorizontalItemList(
                      tvSeries: data.popularMovies,
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
                Navigator.pushNamed(context, TopRatedTvPage.route);
              },
            ),
            Consumer<TvListProvider>(builder: (context, data, _) {
              if (data.topRatedTvsState == RequestState.loaded ||
                  data.topRatedTvs.isNotEmpty) {
                return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: HorizontalItemList(
                      tvSeries: data.topRatedTvs,
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

  Widget _drawGenres(TvDetail tv) {
    List<Widget> genreWidget = [];
    for (int i = 0; i < tv.genres.length - 1; i++) {
      genreWidget.add(Text(tv.genres[i].name));
      genreWidget.add(const SizedBox(
        width: 5,
      ));
    }
    return Row(
      children: genreWidget,
    );
  }
}
