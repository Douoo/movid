import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/core/utils/urls.dart';
import '../provider/movie_images_provider.dart';
import '../provider/movie_list_provider.dart';
import '../widgets/loading_widgets.dart';
import 'popular_movies_page.dart';
import 'top_rated_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/horizontal_item_list.dart';
import '../widgets/minimal_detail.dart';
import '../widgets/sub_heading.dart';

class MainMoviePage extends StatefulWidget {
  const MainMoviePage({super.key});

  @override
  State<MainMoviePage> createState() => _MainMoviePageState();
}

class _MainMoviePageState extends State<MainMoviePage> {
  @override
  void initState() {
    final movieProvider =
        Provider.of<MovieListProvider>(context, listen: false);
    Future.microtask(() {
      movieProvider.fetchNowPlayingMovies().whenComplete(() =>
          Provider.of<MovieImagesProvider>(context, listen: false)
              .fetchMovieImages(movieProvider.nowPlayingMovies[0].id));

      movieProvider.fetchPopularMovies();
      movieProvider.fetchTopRatedMovies();
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
            Consumer<MovieListProvider>(
              builder: (context, data, child) {
                if (data.nowPlayingState == RequestState.loaded) {
                  return FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 575.0,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 15),
                        onPageChanged: (index, reason) {
                          Provider.of<MovieImagesProvider>(context,
                                  listen: false)
                              .fetchMovieImages(
                                  data.nowPlayingMovies[index].id);
                        },
                      ),
                      items: data.nowPlayingMovies.map((movie) {
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
                                  movie: movie,
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
                                  imageUrl: Urls.imageUrl(movie.posterPath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 16.0),
                                  child: Consumer<MovieImagesProvider>(
                                    builder: (context, data, child) {
                                      if (data.state == RequestState.loaded) {
                                        if (data
                                            .mediaImages.logoPaths.isEmpty) {
                                          return Text(movie.title);
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
              valueKey: 'seePopularMovies',
              text: 'Popular',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                PopularMoviesPage.route,
              ),
            ),
            Consumer<MovieListProvider>(builder: (context, data, _) {
              if (data.popularMoviesState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    movies: data.popularMovies,
                  ),
                );
              } else if (data.popularMoviesState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return const LoadingWidget();
              }
            }),
            SubHeading(
              valueKey: 'seeTopRatedMovies',
              text: 'Top rated',
              onSeeMoreTapped: () => Navigator.pushNamed(
                context,
                TopRatedMoviesPage.route,
              ),
            ),
            Consumer<MovieListProvider>(builder: (context, data, _) {
              if (data.topRatedMoviesState == RequestState.loaded) {
                return FadeIn(
                  duration: const Duration(milliseconds: 500),
                  child: HorizontalItemList(
                    movies: data.topRatedMovies,
                  ),
                );
              } else if (data.topRatedMoviesState == RequestState.error) {
                return const Center(child: Text('Load data failed'));
              } else {
                return const LoadingWidget();
              }
            }),
          ],
        ),
      ),
    );
  }
}
