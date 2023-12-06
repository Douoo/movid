import 'package:flutter/material.dart';
import 'package:movid/core/presentation/pages/about_page.dart';
import 'package:movid/core/presentation/pages/watchlist_page.dart';
import 'package:movid/core/presentation/provider/home_provider.dart';
import 'package:movid/core/styles/colors.dart';
import 'package:movid/core/utils/state_enum.dart';
import 'package:movid/features/movies/presentation/pages/main_movie_page.dart';
import 'package:movid/features/search/presentation/pages/search_movie_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String route = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //Animation and Animation Controller
  late AnimationController _drawerAnimationController;
  late Animation _drawerTween;

  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  @override
  void initState() {
    _drawerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _drawerTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _drawerAnimationController,
        curve: Curves.easeInCirc,
      ),
    );

    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 0),
    );

    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: Colors.black54,
    ).animate(_colorAnimationController);

    super.initState();
  }

  @override
  void dispose() {
    _drawerAnimationController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  void toggle() {
    _drawerAnimationController.isDismissed
        ? _drawerAnimationController.forward()
        : _drawerAnimationController.reverse();
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 350);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kSpaceGrey,
      child: AnimatedBuilder(
        animation: _drawerTween,
        builder: (context, child) {
          double slide = 250.0 * _drawerTween.value;
          double scale = 1.0 - (_drawerTween.value * 0.15);
          double radius = _drawerTween.value * 30.0;
          double rotate = _drawerTween.value * -0.139626;
          double toolbarOpacity = 1.0 - _drawerTween.value;

          return Stack(
            children: [
              SizedBox(
                width: 220,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: toggle,
                        style: IconButton.styleFrom(
                          backgroundColor: kWhiteColor,
                          foregroundColor: kRichBlack,
                        ),
                        icon: const Icon(Icons.close),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      ListTile(
                        key: const Key('movieListTile'),
                        onTap: () {
                          toggle();
                          Provider.of<HomeProvider>(context)
                              .setContentType(ContentType.movie);
                        },
                        leading: const Icon(Icons.movie_outlined),
                        title: const Text('Movies'),
                        iconColor: kWhiteColor,
                        textColor: kWhiteColor,
                        style: ListTileStyle.drawer,
                        selected:
                            Provider.of<HomeProvider>(context).contentType ==
                                ContentType.movie,
                        selectedTileColor: primaryColor,
                        selectedColor: kWhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      ListTile(
                        key: const Key('tvListTile'),
                        onTap: () {
                          toggle();
                          Provider.of<HomeProvider>(context)
                              .setContentType(ContentType.tvSeries);
                        },
                        leading: const Icon(Icons.tv),
                        title: const Text('TV Series'),
                        iconColor: kWhiteColor,
                        textColor: kWhiteColor,
                        style: ListTileStyle.drawer,
                        selected:
                            Provider.of<HomeProvider>(context).contentType ==
                                ContentType.tvSeries,
                        selectedTileColor: primaryColor,
                        selectedColor: kWhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      ListTile(
                        key: const Key('watchlistTile'),
                        onTap: () => Navigator.pushNamed(
                          context,
                          WatchlistPage.route,
                        ),
                        leading: const Icon(Icons.star_border),
                        title: const Text('Watchlist'),
                        iconColor: kWhiteColor,
                        textColor: kWhiteColor,
                        style: ListTileStyle.drawer,
                      ),
                      ListTile(
                        key: const Key('aboutListTile'),
                        onTap: () =>
                            Navigator.pushNamed(context, AboutPage.route),
                        leading: const Icon(Icons.info_outline),
                        title: const Text('About'),
                        iconColor: kWhiteColor,
                        textColor: kWhiteColor,
                        style: ListTileStyle.drawer,
                      ),
                    ],
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(slide)
                  ..scale(scale)
                  ..rotateZ(rotate),
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: AnimatedBuilder(
                      animation: _colorTween,
                      builder: (context, child) {
                        return Scaffold(
                          extendBodyBehindAppBar: true,
                          appBar: AppBar(
                            toolbarOpacity: toolbarOpacity,
                            leading: IconButton(
                              key: const Key('menuButton'),
                              onPressed: toggle,
                              icon: const Icon(Icons.menu),
                              tooltip: 'Menu',
                              splashRadius: 20,
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  //TODO: Add search function for tv
                                  Navigator.pushNamed(
                                      context, MovieSearchPage.routeName);
                                },
                                icon: const Icon(
                                  Icons.search,
                                  color: kWhiteColor,
                                ),
                              )
                            ],
                            backgroundColor: _colorTween.value,
                            elevation: 0,
                          ),
                          body: NotificationListener<ScrollNotification>(
                            onNotification: _scrollListener,
                            child: Provider.of<HomeProvider>(context)
                                        .contentType ==
                                    ContentType.movie
                                ? const MainMoviePage()
                                : const SizedBox(),
                          ),
                        );
                      }),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
