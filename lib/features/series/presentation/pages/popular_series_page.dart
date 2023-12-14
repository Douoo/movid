import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/series/presentation/provider/popular_series_provider.dart';

import 'package:provider/provider.dart';

import '../widgets/item_card.dart';

class PopularTvPage extends StatefulWidget {
  static const String route = '/popularTv';
  const PopularTvPage({super.key});

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    Future.microtask(() => Provider.of<PopularTvProvider>(
          context,
          listen: false,
        ).fetchPopularTv);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Popular Tv tv'),
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvProvider>(
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
                  key: const Key('popularMoviesListView'),
                  itemBuilder: (context, index) {
                    final movie = data.tv[index];
                    return TvItemCard(
                      item: movie,
                    );
                  },
                  itemCount: data.tv.length,
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
