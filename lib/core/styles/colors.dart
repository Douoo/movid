import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF040257);
const Color secondaryColor = Color(0xFF607EAA);
const Color surfaceColor = Color(0xFF07C607);
const Color accentColor = Color(0xFFB7C4CF);
const Color kNeutral700 = Color(0xFFEAE3D2);
const Color kNeutral500 = Color(0xFFF9F5EB);
const Color kNeutral300 = Color(0xFFF1F6F9);
const Color kRichBlack = Color(0xFF27374D);
const Color kBlackColor = Color(0xFF000000);
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
