import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wemo/providers/number_provider.dart';
import 'package:wemo/screens/homescreen/homescreen.dart';
import 'package:wemo/screens/numbersetupscreen/addnumberscreen.dart';
import 'package:wemo/screens/splashscreen/splashscreen.dart';
import 'package:wemo/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

  
        ChangeNotifierProvider<MomoNumberData>(create: (context)=> MomoNumberData()),
      ],
      child: MaterialApp(
        title: 'Wemo',
        debugShowCheckedModeBanner: false,
        theme: wemoLightTheme(context),
        home: const SplashScreen(),
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          AddNumberScreen.id:(context) => const AddNumberScreen(),
        },
      ),
    );
  }
}
