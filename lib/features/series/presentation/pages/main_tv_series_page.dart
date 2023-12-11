import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/movies/presentation/pages/main_movie_page.dart';
import 'package:movid/features/movies/presentation/widgets/sub_heading.dart';
import 'package:movid/features/series/domain/entites/series_detail.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:movid/features/series/presentation/provider/series_images_provider.dart';
import 'package:movid/features/series/presentation/provider/series_list_provider.dart';
import 'package:movid/features/series/presentation/widgets/vertical_item_list_card.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MainSeriesPage extends StatefulWidget {
  const MainSeriesPage({super.key});

  @override
  State<MainSeriesPage> createState() => _MainSeriesPageState();
}

class _MainSeriesPageState extends State<MainSeriesPage> {
  @override
  void initState() {
    final movieProvider =
        Provider.of<TvSeriesListProvider>(context, listen: false);

    Future.microtask(() {
      movieProvider.fetchOnAirTvs().whenComplete(() {
        Provider.of<TvSeriesImagesProvider>(context, listen: false)
            .fetchSeriesImages(movieProvider.onAirTvs[0].id!);
        Provider.of<TvSeriesDetailProvider>(context, listen: false)
            .fetchDetailTvSeries(movieProvider.onAirTvs[0].id!);
      });

      movieProvider.fetchPopularSeries();
      movieProvider.fetchTopRatedSeries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        key: const Key('movieScrollView'),
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
                        autoPlayInterval: const Duration(seconds: 5),
                        onPageChanged: (index, reason) {
                          Provider.of<TvSeriesImagesProvider>(context,
                                  listen: false)
                              .fetchSeriesImages(data.onAirTvs[index].id!);
                          Provider.of<TvSeriesDetailProvider>(context,
                                  listen: false)
                              .fetchDetailTvSeries(data.onAirTvs[index].id!);
                        },
                      ),
                      items: data.onAirTvs.map((movie) {
                        return GestureDetector(
                          onTap: () {
                            //TODO: Implement navigation
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
                                      movie.poster ?? movie.backdropPath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 16.0, left: 20),
                                child: Consumer<TvSeriesImagesProvider>(
                                  builder: (context, seriesImageData, child) {
                                    if (seriesImageData.state ==
                                        RequestState.loaded) {
                                      return Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(movie.title!),
                                                  ],
                                                ),
                                                const SizedBox(height: 8),
                                                Consumer<
                                                    TvSeriesDetailProvider>(
                                                  builder: (context, detailData,
                                                      child) {
                                                    if (detailData.state ==
                                                        RequestState.loaded) {
                                                      return Row(
                                                        children: [
                                                          Text(movie.rating
                                                              .toString()
                                                              .substring(0, 3)),
                                                          const SizedBox(
                                                              width: 8),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          _drawGeners(detailData
                                                              .seriesDetail)
                                                        ],
                                                      );
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
                                                        movie.description
                                                            .toString(),
                                                        maxLines: 4,
                                                        style: const TextStyle(
                                                            fontSize: 10),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]));

                                      // return Align(
                                      //   alignment: Alignment.bottomCenter,
                                      //   child: CachedNetworkImage(
                                      //     width: 200.0,
                                      //     imageUrl: Urls.imageUrl(
                                      //       data.mediaImages.posterPaths[0],
                                      //     ),
                                      //   ),
                                      // );
                                    } else if (seriesImageData.state ==
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
              valueKey: 'seePopularMovies',
              text: 'Popular',
              onSeeMoreTapped: () {},
            ),
            Consumer<TvSeriesListProvider>(builder: (context, data, _) {
              if (data.popularTvsState == RequestState.loaded ||
                  data.popularMovies.isNotEmpty) {
                return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: VerticalItemList(
                      series: data.popularMovies,
                      isTopRated: false,
                    ));
              } else if (data.popularTvsState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return const LoadingWidget();
              }
            }),
            SubHeading(
              valueKey: 'seeTopRatedMovies',
              text: 'Top rated',
              onSeeMoreTapped: () {
                //TODO: Navigate to popular
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
            //   } else if (data.topRatedMoviesState == RequestState.error) {
            //     return const Center(child: Text('Load data failed'));
            //   } else {
            //     return LoadingWidget();
            //   }
            // }),
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
