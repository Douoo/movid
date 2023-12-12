import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/domain/entites/genre.dart';
import 'package:movid/features/series/presentation/provider/seasons_provider.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:movid/features/series/presentation/provider/series_watch_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/styles/colors.dart';
import '../widgets/series_detail_card.dart';

class DetailSeriesPage extends StatefulWidget {
  static const route = "DetailSeriesPage";
  final int? seriesId;
  const DetailSeriesPage({super.key, this.seriesId});

  @override
  State<DetailSeriesPage> createState() => _DetailSeriesPageState();
}

class _DetailSeriesPageState extends State<DetailSeriesPage> {
  List<int> items = [
    1,
  ];
  int? selectedItem = 1;

  void seasonsBuilder(int item) {
    print(" fsjlj ${item}");
    for (int i = 2; i < item; i++) {
      items.add(i);
    }
    print(items.length);
  }

  void fetchSeasonEpisodes(season) {
    setState(() {
      selectedItem = season;
    });
    final seasonsProvider =
        Provider.of<SeasonsProvider>(context, listen: false);

    seasonsProvider.fetchSeasons(widget.seriesId!, season);
  }

  @override
  void initState() {
    print("series id ${widget.seriesId}");
    final movieDetailProvider =
        Provider.of<TvSeriesDetailProvider>(context, listen: false);
    final seasonsProvider =
        Provider.of<SeasonsProvider>(context, listen: false);
    Future.microtask(
      () {
        movieDetailProvider.fetchDetailTvSeries(widget.seriesId!);
        movieDetailProvider.loadWatchListStatus(widget.seriesId!);
      },
    );
    seasonsBuilder(movieDetailProvider.seriesDetail.numberOfSeasons);
    seasonsProvider.fetchSeasons(widget.seriesId!, 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Consumer<TvSeriesDetailProvider>(
          builder: (context, provider, child) {
            if (provider.state == RequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.state == RequestState.loaded) {
              final tvDetail = provider.seriesDetail;
              final isAddedToWatchList = provider.isAddedToWatchList;

              return CustomScrollView(
                key: const Key("seriesDetailPage"),
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 250,
                    flexibleSpace: FlexibleSpaceBar(
                      background: FadeIn(
                        duration: const Duration(milliseconds: 500),
                        child: ShaderMask(
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
                                stops: [
                                  0.0,
                                  0.5,
                                  1.0,
                                  1.0
                                ]).createShader(
                              Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width,
                            imageUrl: Urls.imageUrl(tvDetail.posterPath ??
                                tvDetail.backdropPath ??
                                ""),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) {
                              return Container(
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      size: 50,
                                    ),
                                    Text("Error Loading Image")
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(19),
                      child: FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tvDetail.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                    ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Text(
                                      '${(tvDetail.language[0].toUpperCase())} | ${tvDetail.releaseDate}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        (tvDetail.voteAverage / 2)
                                            .toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        '(${tvDetail.voteAverage})',
                                        style: const TextStyle(
                                          fontSize: 1.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 16.0),
                                  // Text(
                                  //   _showDuration(tvDetail.runtime as int),
                                  //   style: const TextStyle(
                                  //     color: Colors.white70,
                                  //     fontSize: 16.0,
                                  //     fontWeight: FontWeight.w500,
                                  //     letterSpacing: 1.2,
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                key: const Key('movieToWatchlist'),
                                onPressed: () async {
                                  if (!isAddedToWatchList) {
                                    await Provider.of<TvSeriesDetailProvider>(
                                            context,
                                            listen: false)
                                        .addToWatchList(tvDetail);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text(
                                        "Successfully added ${tvDetail.title} to watchList",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ));
                                  } else {
                                    await Provider.of<TvSeriesDetailProvider>(
                                            context,
                                            listen: false)
                                        .removeFromWatchList(tvDetail);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.black,
                                      content: Text(
                                        "Successfully removed ${tvDetail.title} From watchList",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isAddedToWatchList
                                      ? Colors.grey[850]
                                      : primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width,
                                    42.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isAddedToWatchList
                                        ? const Icon(Icons.check,
                                            color: Colors.white)
                                        : const Icon(Icons.add,
                                            color: kWhiteColor),
                                    const SizedBox(width: 16.0),
                                    Text(
                                      isAddedToWatchList
                                          ? 'Added to watchlist'
                                          : 'Add to watchlist',
                                      style: const TextStyle(
                                        color: kWhiteColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Storyline',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                tvDetail.overView,
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w200,
                                  letterSpacing: 1.2,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Genres',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 8.0),
                              _showGenres(tvDetail.genres),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: const Text("Episodes"),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      DropdownButtonFormField<int>(
                                        decoration:
                                            const InputDecoration.collapsed(
                                                hintText: ""),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        value: selectedItem,
                                        items: items
                                            .map(
                                                (item) => DropdownMenuItem<int>(
                                                    value: item,
                                                    child: Text(
                                                      "Season ${item}",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )))
                                            .toList(),
                                        onChanged: (item) => setState(
                                            () => fetchSeasonEpisodes(item)),
                                      ),
                                      Consumer<SeasonsProvider>(
                                        builder: (context, data, child) {
                                          if (data.state ==
                                              RequestState.loaded) {
                                            return ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemExtent: 100.0,
                                              itemCount: data.season.length,
                                              itemBuilder: (context, index) {
                                                final episode =
                                                    data.season[index];
                                                return Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: ListTile(
                                                    visualDensity:
                                                        const VisualDensity(
                                                            vertical: 4,
                                                            horizontal: 4),
                                                    leading: Container(
                                                      width: 100,
                                                      height: 100,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 500,
                                                          imageUrl: Urls
                                                              .imageUrl(episode
                                                                      .still_path ??
                                                                  tvDetail
                                                                      .backdropPath ??
                                                                  ""),
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                              url, error) {
                                                            return Container(
                                                              child:
                                                                  const Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .warning,
                                                                    size: 50,
                                                                  ),
                                                                  Text(
                                                                      "Error Loading Image")
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      "${index + 1}. ${episode.name.toString()}",
                                                      style: const TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                    subtitle: Text(
                                                      "${episode.description.toString()}",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w200),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          } else if (data.state ==
                                              RequestState.loading) {
                                            return const CircularProgressIndicator();
                                          } else {
                                            return const Center(
                                                child: Text("No data"));
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: Text(provider.message),
            );
          },
        ),
      ),
    );
  }

  Widget _showGenres(List<Genre> genres) {
    if (genres.isEmpty) {
      return const SizedBox();
    }
    return Wrap(
      children: genres.map((genre) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          margin: const EdgeInsets.only(right: 8, bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(color: kWhiteColor),
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent,
          ),
          child: Text(
            genre.name,
            style: const TextStyle(
              color: kWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _showRecommendations() {
    return Consumer<TvSeriesDetailProvider>(
      builder: (context, data, child) {
        if (data.recommendedSeriesState == RequestState.loaded) {
          return SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final recommendation = data.recommendedTvSeries[index];
                return FadeInUp(
                  from: 20,
                  duration: const Duration(milliseconds: 500),
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
                          return SeriesDetailCard(
                            series: recommendation,
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: CachedNetworkImage(
                        imageUrl: Urls.imageUrl(recommendation.poster ?? ''),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[850]!,
                          highlightColor: Colors.grey[800]!,
                          child: Container(
                            height: 170.0,
                            width: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                            color: Colors.grey,
                            child: const Icon(
                              Icons.error,
                            )),
                        height: 180.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              childCount: data.recommendedTvSeries.length,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 3
                      : 4,
            ),
          );
        } else if (data.recommendedSeriesState == RequestState.error) {
          return SliverToBoxAdapter(child: Center(child: Text(data.message)));
        } else {
          return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Future<bool> _onWillPop() async {
    await fetchWatchListSeries();
    return true;
  }

  Future fetchWatchListSeries() async {
    Provider.of<TvSeriesWatchListProvider>(context, listen: false)
        .fetchWatchListSeries();
  }
}
