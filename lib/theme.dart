import 'package:flutter/material.dart';
import 'constants.dart';

///---------------Light Theme----------////
ThemeData wemoLightTheme(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      primaryColor: kPurple,
      primaryColorLight: kPurple80,
      primaryColorDark: kPurple,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: kDark),
      primaryIconTheme: const IconThemeData(color: kDark),
      fontFamily: 'Urbanist',
      textTheme: TextTheme(
        bodyText1: kBodyBold.copyWith(color: kDark),
        bodyText2: kBody.copyWith(color: kDark),
        headline1: kHeading.copyWith(color: kDark),
        headline2: kHeadingLight.copyWith(color: kDark),
      ),
      colorScheme: const ColorScheme.light().copyWith(secondary: kFuchsia),
      cardColor: kDark20,
      canvasColor: Colors.transparent);
}

///-----------------Dark Theme--------------////

ThemeData wemoDarkTheme(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      primaryColor: kPurple,
      primaryColorLight: kPurple80,
      primaryColorDark: kPurple,
      scaffoldBackgroundColor: Colors.black,
      brightness: Brightness.dark,
      backgroundColor: kDark,
      iconTheme: const IconThemeData(color: Colors.white),
      primaryIconTheme: const IconThemeData(color: Colors.white),
      fontFamily: 'Urbanist',
      textTheme: TextTheme(
        bodyText1: kBodyBold.copyWith(color: Colors.white),
        bodyText2: kBody.copyWith(color: Colors.white),
        headline1: kHeading.copyWith(color: Colors.white),
        headline2: kHeadingLight.copyWith(color: Colors.white),
      ),
      colorScheme: const ColorScheme.dark().copyWith(secondary: kFuchsia),
      cardColor: kDark80,
      canvasColor: Colors.transparent);
}
