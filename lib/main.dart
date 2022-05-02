import 'package:flutter/material.dart';
import 'package:wemo/screens/homescreen/homescreen.dart';
import 'package:wemo/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wemo',
      debugShowCheckedModeBanner: false,
      theme: wemoLightTheme(context),
      home: const HomeScreen(),
      routes: {
        HomeScreen.id: (context)=> const HomeScreen(),
      },
    );
  }
}

