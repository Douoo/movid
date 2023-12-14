import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class AboutPage extends StatelessWidget {
  static const String route = '/about';
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: kRichBlack,
                  child: const Center(
                    child: Text(
                      'MoviD',
                      style: TextStyle(
                        fontSize: 64.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32.0),
                  color: kRichBlack,
                  child: const Text(
                    'MoviD is a movie and tv tv catalog app developed by Biruksew B. and Biruk G. to showcase the flexiblity of the Flutter SDK and their expertise in Flutter app development profession.',
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
