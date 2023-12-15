import 'package:flutter/material.dart';
import 'package:movid/core/styles/colors.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/search/presentation/provider/tv_search_provider.dart';
import 'package:movid/features/series/presentation/widgets/item_card.dart';
import 'package:provider/provider.dart';

class SearchTvPage extends StatelessWidget {
  static const routeName = '/search_tv';

  const SearchTvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              key: const Key('enterMovieQuery'),
              onChanged: (query) {
                Provider.of<TvSearchProvider>(context, listen: false)
                    .searchTvs(query);
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                filled: true,
                fillColor: const Color(0xFF141414),
                suffixIcon: const Icon(
                  Icons.search,
                  color: Colors.white70,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: kRichBlack),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: accentColor),
                ),
              ),
              textInputAction: TextInputAction.search,
              cursorColor: Colors.white,
            ),
            Consumer<TvSearchProvider>(
              builder: (context, data, child) {
                if (data.queryTv.isNotEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Search result',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Consumer<TvSearchProvider>(
              builder: (context, data, child) {
                if (data.searchState == RequestState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.searchState == RequestState.loaded) {
                  final result = data.queryTv;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final tv = result[index];
                        return TvItemCard(
                          item: tv,
                        );
                      },
                    ),
                  );
                } else if (data.searchState == RequestState.error) {
                  return Expanded(
                    child: Center(
                      child: Text(data.message),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/movie_icon.png'),
                        Text(
                          'Search a tv',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const Text('Find the tv you are looking for')
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
