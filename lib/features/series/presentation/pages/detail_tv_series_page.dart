import 'package:flutter/material.dart';

class DetailSeriesPage extends StatefulWidget {
  const DetailSeriesPage({super.key});

  @override
  State<DetailSeriesPage> createState() => _DetailSeriesPageState();
}

class _DetailSeriesPageState extends State<DetailSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 2, child: SizedBox()),
          Expanded(flex: 7, child: SizedBox())
        ],
      ),
    );
  }
}
