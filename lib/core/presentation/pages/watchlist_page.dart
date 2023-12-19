import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/presentation/provider/watchlist_movies_provider.dart';
import 'package:movid/features/movies/presentation/widgets/item_card.dart'
    as movie;
import 'package:movid/features/tv/presentation/provider/series_watch_list_provider.dart';
import 'package:movid/features/tv/presentation/widgets/item_card.dart';

import 'package:provider/provider.dart';

class WatchlistPage extends StatefulWidget {
  static const String route = '/watchlist_page';
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<MovieWatchlistProvider>(
        context,
        listen: false,
      ).fetchWatchlistMovies();
      Provider.of<TvWatchListProvider>(context, listen: false)
          .fetchWatchListTv();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Movies',
            ),
            Tab(
              text: 'TV',
            )
          ]),
        ),
        body: TabBarView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<MovieWatchlistProvider>(
              builder: (context, data, child) {
                if (data.state == RequestState.loaded) {
                  final watchlistMovies = data.movies;
                  return ListView.builder(
                    itemCount: watchlistMovies.length,
                    itemBuilder: (context, index) {
                      return movie.ItemCard(movie: watchlistMovies[index]);
                    },
                  );
                }
                if (data.state == RequestState.error) {
                  return Container(
                    alignment: Alignment.center,
                    child: Column(children: [
                      const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 50,
                      ),
                      Text(data.message)
                    ]),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                );
              },
            ),
          ),
          Consumer<TvWatchListProvider>(
            builder: (context, data, child) {
              if (data.state == RequestState.loaded) {
                final watchlistTv = data.movies;
                return ListView.builder(
                  itemCount: watchlistTv.length,
                  itemBuilder: (context, index) {
                    return TvItemCard(item: watchlistTv[index]);
                  },
                );
              }
              if (data.state == RequestState.error) {
                return Container(
                  alignment: Alignment.center,
                  child: Column(children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    Text(data.message)
                  ]),
                );
              }
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            },
          )
        ]),
      ),
    );
  }
}
