import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:provider/provider.dart';

import '../provider/top_rated_movies_provider.dart';
import '../widgets/movie_card.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const String route = '/top_rated';
  const TopRatedMoviesPage({super.key});

  @override
  State<TopRatedMoviesPage> createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    Future.microtask(
      () => Provider.of<TopRatedMoviesProvider>(context).fetchTopRatedMovies(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedMoviesProvider>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 500),
                child: ListView.builder(
                  key: const Key('topRatedMoviesListView'),
                  itemBuilder: (context, index) {
                    final movie = data.movies[index];
                    return MovieCard(
                      movie: movie,
                    );
                  },
                  itemCount: data.movies.length,
                ),
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
