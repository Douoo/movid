import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/core/utils/urls.dart';
import 'package:movid/features/series/domain/entites/genre.dart';
import 'package:movid/features/series/presentation/provider/season_episodes_provider.dart';
import 'package:movid/features/series/presentation/provider/series_detail_provider.dart';
import 'package:movid/features/series/presentation/provider/series_watch_list_provider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/styles/colors.dart';
import '../../domain/entites/series_detail.dart';
import '../widgets/minimal_detail.dart';

class DetailSeriesPage extends StatefulWidget {
  static const route = "DetailSeriesPage";
  final int? tvId;
  const DetailSeriesPage({super.key, this.tvId});

  @override
  State<DetailSeriesPage> createState() => _DetailSeriesPageState();
}

class _DetailSeriesPageState extends State<DetailSeriesPage> {
  @override
  void initState() {
    final tvDetailProvider =
        Provider.of<TvSeriesDetailProvider>(context, listen: false);
    Future.microtask(
      () {
        tvDetailProvider.fetchDetailTvSeries(widget.tvId!);
        tvDetailProvider.loadWatchListStatus(widget.tvId!);
        Provider.of<SeasonEpisodesProvider>(context, listen: false)
            .fetchTvSeasonEpisodes(widget.tvId!, 1);
      },
    );

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
              final isAddedToWatchlist = provider.isAddedToWatchList;

              return TvDetailContent(
                tvDetail: tvDetail,
                seasonNumber: tvDetail.numberOfSeasons,
                isAddedToWatchlist: isAddedToWatchlist,
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

  Future<bool> _onWillPop() async {
    await fetchWatchListSeries();
    return true;
  }

  Future fetchWatchListSeries() async {
    Provider.of<TvSeriesWatchListProvider>(context, listen: false)
        .fetchWatchListSeries();
  }
}

class TvDetailContent extends StatefulWidget {
  final SeriesDetail tvDetail;
  final int seasonNumber;
  final bool isAddedToWatchlist;
  const TvDetailContent(
      {super.key,
      required this.tvDetail,
      required this.seasonNumber,
      required this.isAddedToWatchlist});

  @override
  State<TvDetailContent> createState() => _TvDetailContentState();
}

class _TvDetailContentState extends State<TvDetailContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _selectedTab = 0;
  List<int> _seasons = [];
  int _currentSelectedSeason = 1;
  late SeriesDetail tvDetail;
  late int seasonNumber;
  late bool isAddedToWatchlist;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    tvDetail = widget.tvDetail;
    seasonNumber = widget.seasonNumber;
    isAddedToWatchlist = widget.isAddedToWatchlist;
    populateSeason(seasonNumber);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  imageUrl: Urls.imageUrl(
                      tvDetail.posterPath ?? tvDetail.backdropPath ?? ""),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning,
                          size: 50,
                        ),
                        Text("Error Loading Image")
                      ],
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
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
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
                              (tvDetail.voteAverage / 2).toStringAsFixed(1),
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
                        if (!isAddedToWatchlist) {
                          await Provider.of<TvSeriesDetailProvider>(context,
                                  listen: false)
                              .addToWatchList(tvDetail);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              "Successfully added ${tvDetail.title} to watchList",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ));
                        } else {
                          await Provider.of<TvSeriesDetailProvider>(context,
                                  listen: false)
                              .removeFromWatchList(tvDetail);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              "Successfully removed ${tvDetail.title} From watchList",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ));
                        }
                        // ignore: use_build_context_synchronously
                        final message = Provider.of<TvSeriesDetailProvider>(
                                context,
                                listen: false)
                            .watchlistMessage;

                        if (message ==
                                TvSeriesDetailProvider
                                    .watchlistAddSuccessMessage ||
                            message ==
                                TvSeriesDetailProvider
                                    .watchlistRemoveSuccessMessage) {
                          Fluttertoast.showToast(
                              msg: message,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: message ==
                                      TvSeriesDetailProvider
                                          .watchlistAddSuccessMessage
                                  ? kSpaceGrey
                                  : Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(message),
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isAddedToWatchlist
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
                          isAddedToWatchlist
                              ? const Icon(Icons.check, color: Colors.white)
                              : const Icon(Icons.add, color: kWhiteColor),
                          const SizedBox(width: 16.0),
                          Text(
                            isAddedToWatchlist
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
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 16),
          sliver: SliverToBoxAdapter(
            child: FadeIn(
              duration: const Duration(milliseconds: 500),
              child: TabBar(
                controller: _tabController,
                labelColor: kWhiteColor,
                indicator: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: primaryColor,
                      style: BorderStyle.solid,
                      width: 4.0,
                    ),
                  ),
                ),
                tabs: [
                  Tab(text: 'Episodes'.toUpperCase()),
                  Tab(text: 'More like this'.toUpperCase()),
                ],
              ),
            ),
          ),
        ),
        Builder(builder: (context) {
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                _selectedTab = _tabController.index;
              });
            }
          });
          return _selectedTab == 0
              ? SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  sliver: SliverToBoxAdapter(
                    child: FadeIn(
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[850],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton<int>(
                              onChanged: (value) {
                                setState(() {
                                  _currentSelectedSeason = value!;
                                });

                                Provider.of<SeasonEpisodesProvider>(
                                  context,
                                  listen: false,
                                ).fetchTvSeasonEpisodes(
                                  tvDetail.id,
                                  _currentSelectedSeason,
                                );
                              },
                              items: _seasons
                                  .map(
                                    (item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        'Season $item',
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              value: _currentSelectedSeason,
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SliverToBoxAdapter();
        }),
        Builder(builder: (context) {
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                _selectedTab = _tabController.index;
              });
            }
          });

          return _selectedTab == 0
              ? SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  sliver: _showSeasonEpisodes(),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
                  sliver: _showRecommendations(),
                );
        }),
      ],
    );
  }

  void populateSeason(int seasonNumber) {
    for (int i = 1; i < seasonNumber; i++) {
      _seasons.add(i);
    }
  }

  Widget _showSeasonEpisodes() {
    return Consumer<SeasonEpisodesProvider>(
      builder: (context, data, child) {
        if (data.state == RequestState.loaded) {
          return data.seasonEpisodes.isEmpty
              ? const SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Comming Soon!',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final seasonEpisode = data.seasonEpisodes[index];
                      return FadeInUp(
                        from: 20,
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: Urls.imageUrl(
                                            seasonEpisode.stillPath ?? ''),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 200.0,
                                          child: Text(
                                            '${seasonEpisode.episodeNumber}. ${seasonEpisode.name}',
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          DateFormat('MMM dd, yyyy').format(
                                            DateTime.parse(
                                                seasonEpisode.airDate ?? '-'),
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12.0,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  seasonEpisode.overview ?? 'N/A',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10.0,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: data.seasonEpisodes.length,
                  ),
                );
        }
        if (data.state == RequestState.error) {
          return SliverToBoxAdapter(child: Center(child: Text(data.message)));
        } else {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
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
                          return MinimalDetail(
                            tv: recommendation,
                          );
                        },
                      );
                    },
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      child: SizedBox(
                        height: 800,
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
}
