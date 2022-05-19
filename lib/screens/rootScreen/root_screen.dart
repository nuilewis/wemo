import 'package:flutter/material.dart';
import 'package:wemo/screens/homescreen/homescreen.dart';
import 'package:wemo/screens/onboardingscreen/onboarding_screen.dart';
import 'package:wemo/services/shared_prefs/shared_prefs_startup.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late Widget screenToReturn;

  @override
  void initState() {
    ///Initialise shared prefs
    SharedPrefsStartup().initStartupSharedPrefs();

    ///get the number of times the user has started the app
    SharedPrefsStartup().getStartupCount();

    ///check if the user is starting the app for the first time, then show onaboarding
    ///screen, else go to homes screen
    if (SharedPrefsStartup().isFirstTime() == true) {
      screenToReturn = const OnboardingScreen();
      SharedPrefsStartup().increaseStartupCount();
    } else {
      screenToReturn = const HomeScreen();
      SharedPrefsStartup().increaseStartupCount();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return screenToReturn;
  }
}
