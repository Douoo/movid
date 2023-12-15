import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/presentation/provider/top_rated_series_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/item_card.dart';

class TopRatedSeriesPage extends StatefulWidget {
  static const String route = '/topRatedSeries';
  const TopRatedSeriesPage({super.key});

  @override
  State<TopRatedSeriesPage> createState() => _TopRatedSeriesPageState();
}

class _TopRatedSeriesPageState extends State<TopRatedSeriesPage> {
  @override
  void initState() {
    Future.microtask(() => Provider.of<TopRatedTvSeriesProvider>(
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
        title: const Text('Top Rated Tv Series'),
        backgroundColor: Colors.black.withOpacity(0.6),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvSeriesProvider>(
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
                  key: const Key('topRatedTvListView'),
                  itemBuilder: (context, index) {
                    final movie = data.series[index];
                    return ItemCard(
                      item: movie,
                    );
                  },
                  itemCount: data.series.length,
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
