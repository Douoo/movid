import 'package:flutter/material.dart';
import 'package:movid/features/series/presentation/pages/drawer.dart';
import 'package:movid/features/series/presentation/pages/tv_series.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool changePostion = false;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          DrawerScreen(),
          TvSeriesScreen(),
        ],
      ),
    );
  }
}
