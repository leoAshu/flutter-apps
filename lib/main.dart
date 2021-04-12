import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utility/constants.dart';
import './view/home_screen.dart';
import './model/comics_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ComicsProvider>(
      create: (_) => ComicsProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Constants.primaryColor,
        ),
        home: Home(),
      ),
    );
  }
}
