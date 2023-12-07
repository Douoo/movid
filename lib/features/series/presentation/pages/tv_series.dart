import 'package:flutter/material.dart';

class TvSeriesScreen extends StatefulWidget {
  const TvSeriesScreen({super.key});

  @override
  State<TvSeriesScreen> createState() => _TvSeriesScreenState();
}

class _TvSeriesScreenState extends State<TvSeriesScreen> {
  double xOffset = 0;
  double yOffset = 0;

  bool isDrawerShow = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      left: isDrawerShow ? 150.0 : 0.0,
      top: isDrawerShow ? 50 : 0,
      child: SafeArea(
        child: AnimatedContainer(
          transform: Matrix4.translationValues(xOffset, yOffset, 0)
            ..scale(isDrawerShow ? 1.2 : 1.00)
            ..rotateZ(isDrawerShow ? 50 : 0),
          duration: const Duration(milliseconds: 200),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 573,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          child: isDrawerShow
                              ? Icon(Icons.arrow_back)
                              : Icon(Icons.menu),
                          onTap: () {
                            setState(() {
                              isDrawerShow = !isDrawerShow;
                              yOffset == 0 ? 300 : 0;
                            });
                          },
                        ),
                        GestureDetector(
                          child: const Icon(Icons.search),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieCard(
                      headLine: "Trending",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieCard(
                      headLine: "Trending",
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final String? headLine;
  final String? title;
  final String? detail;
  final String? image;
  const MovieCard({this.detail, this.headLine, this.title, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$headLine",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Container(
                height: 176,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white),
                ),
                child: image == null
                    ? Image.asset("assets/image-not-found.png")
                    : Image.network(image!),
              ),
            ],
          )
        ],
      ),
    );
  }
}
