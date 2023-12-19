import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movid/core/utils/state_enum.dart';

import 'package:provider/provider.dart';

import '../provider/popular_series_provider.dart';
import '../widgets/item_card.dart';

class PopularTvPage extends StatefulWidget {
  static const String route = '/popularTv';
  const PopularTvPage({super.key});

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  int page = 2;
  @override
  void initState() {
    Future.microtask(() => Provider.of<PopularTvProvider>(
          context,
          listen: false,
        ).fetchPopularTv());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Popular Tv'),
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
                        data.fetchPopularTv();

                        return true;
                      }
                      return false;
                    }
                    return false;
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    key: const Key('popularMoviesListView'),
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
