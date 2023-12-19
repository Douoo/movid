import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFFFC4F03);
const Color accentColor = Color(0xFFB7C4CF);
const Color kRichBlack = Color(0xFF1E1E1E);
const Color kSpaceGrey = Color(0xFF26262F);
const Color kWhiteColor = Color(0xFFFFFFFF);

const kColorScheme = ColorScheme(
  primary: primaryColor,
  primaryContainer: Colors.redAccent,
  secondary: accentColor,
  secondaryContainer: accentColor,
  surface: kRichBlack,
  background: kRichBlack,
  error: Colors.redAccent,
  onPrimary: kRichBlack,
  onSecondary: Colors.white,
  onSurface: Colors.white,
  onBackground: Colors.white,
  onError: Colors.white,
  brightness: Brightness.dark,
);
