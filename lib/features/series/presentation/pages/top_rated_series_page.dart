import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/presentation/provider/top_rated_series_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/item_card.dart';

class TopRatedTvPage extends StatefulWidget {
  static const String route = '/topRatedTv';
  const TopRatedTvPage({super.key});

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    Future.microtask(() => Provider.of<TopRatedTvProvider>(
          context,
          listen: false,
        ).fetchTopRatedMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Top Rated Tv'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvProvider>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading && data.tv.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded ||
                data.tv.isNotEmpty) {
              return FadeInUp(
                from: 20,
                duration: const Duration(milliseconds: 500),
                child: NotificationListener(
                  onNotification: (_onScrollNotification) {
                    if (_onScrollNotification is ScrollEndNotification) {
                      final before = _onScrollNotification.metrics.extentBefore;
                      final max = _onScrollNotification.metrics.maxScrollExtent;
                      if (before == max) {
                        data.fetchTopRatedMovies();
                        return true;
                      }
                      return false;
                    }
                    return false;
                  },
                  child: ListView.builder(
                    key: const Key('topRatedMoviesListView'),
                    itemBuilder: (context, index) {
                      final movie = data.tv[index];
                      return TvItemCard(
                        item: movie,
                      );
                    },
                    itemCount: data.tv.length,
                  ),
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
