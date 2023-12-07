import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/presentation/provider/watchlist_movies_provider.dart';
import 'package:movid/features/movies/presentation/widgets/movie_card.dart';
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
    Future.microtask(() => Provider.of<MovieWatchlistProvider>(
          context,
          listen: false,
        ).fetchWatchlistMovies());
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
              text: 'TV Series',
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
                      return MovieCard(movie: watchlistMovies[index]);
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
          //TODO: Change the following provider widget to a tv watchlist
          Consumer<MovieWatchlistProvider>(
            builder: (context, data, child) {
              if (data.state == RequestState.loaded) {
                final watchlistMovies = data.movies;
                return ListView.builder(
                  itemCount: watchlistMovies.length,
                  itemBuilder: (context, index) {
                    return MovieCard(movie: watchlistMovies[index]);
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
