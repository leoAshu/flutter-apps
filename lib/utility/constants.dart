import 'package:flutter/material.dart';

class Constants {
  // Theme Colors

  static const Map<int, Color> colorPrimary = {
    50: Color.fromRGBO(110, 123, 145, .1),
    100: Color.fromRGBO(110, 123, 145, .2),
    200: Color.fromRGBO(110, 123, 145, .3),
    300: Color.fromRGBO(110, 123, 145, .4),
    400: Color.fromRGBO(110, 123, 145, .5),
    500: Color.fromRGBO(110, 123, 145, .6),
    600: Color.fromRGBO(110, 123, 145, .7),
    700: Color.fromRGBO(110, 123, 145, .8),
    800: Color.fromRGBO(110, 123, 145, .9),
    900: Color.fromRGBO(110, 123, 145, 1),
  };

  static final MaterialColor primaryColor =
      MaterialColor(0xFF6E7B91, colorPrimary);

  static const Map<int, Color> colorSecondary = {
    50: Color.fromRGBO(150, 168, 200, .1),
    100: Color.fromRGBO(150, 168, 200, .2),
    200: Color.fromRGBO(150, 168, 200, .3),
    300: Color.fromRGBO(150, 168, 200, .4),
    400: Color.fromRGBO(150, 168, 200, .5),
    500: Color.fromRGBO(150, 168, 200, .6),
    600: Color.fromRGBO(150, 168, 200, .7),
    700: Color.fromRGBO(150, 168, 200, .8),
    800: Color.fromRGBO(150, 168, 200, .9),
    900: Color.fromRGBO(150, 168, 200, 1),
  };

  static final MaterialColor secondaryColor =
      MaterialColor(0xFF96A8C8, colorPrimary);

  static const Color bgColor = Color.fromRGBO(243, 242, 239, 1);
  static const Color contrastColor = Color.fromRGBO(36, 36, 36, 1);

  // App Labels

  // Tab Labels
  static const String tabHomeLabel = 'Home';
  static const String tabFavLabel = 'Favorites';

  // Action Labels
  static const String actionPrevLabel = 'PREV';
  static const String actionRandomLabel = 'RANDOM';
  static const String actionNextLabel = 'NEXT';
  static const String actionOkLabel = 'OK';

  // Indicator Strings
  static const String imageError = 'Failed to load image!';
  static const String addToFavSuccess = 'Added to Favorites!';
  static const String removeFromFavSuccess = 'Removed from Favorites!';
  static const String emptyFavList = 'No Favorites!';

  static const apiDomain = 'https://www.xkcd.com';
  static const apiEndpoint = '/info.0.json';

  static const String dbName = 'comics.db';
  static const String tableName = 'comics';
}
