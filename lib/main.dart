import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wemo/providers/momo_num_provider.dart';
import 'package:wemo/providers/send_money_provider.dart';
import 'package:wemo/providers/transaction_provider.dart';
import 'package:wemo/screens/homescreen/homescreen.dart';
import 'package:wemo/screens/initialsetupflowscreens/addnumberscreen.dart';
import 'package:wemo/screens/rootScreen/root_screen.dart';
import 'package:wemo/screens/scanscreen/scan_screen.dart';
import 'package:wemo/screens/onboardingscreen//onboarding_screen.dart';
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
        ChangeNotifierProvider<MomoNumberData>(
            create: (context) => MomoNumberData()),
        ChangeNotifierProvider<TransactionData>(
            create: (context) => TransactionData()),
        ChangeNotifierProvider<SendMoneyData>(
            create: (context) => SendMoneyData()),
      ],
      child: MaterialApp(
        title: 'Wemo',
        debugShowCheckedModeBanner: false,
        theme: wemoLightTheme(context),
        //darkTheme: wemoDarkTheme(context),
        home: const RootScreen(),
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          OnboardingScreen.id: (context) => const OnboardingScreen(),
          AddNumberScreen.id: (context) => AddNumberScreen(
                formkey: GlobalKey<FormState>(),
                nameKey: GlobalKey(),
                numberKey: GlobalKey(),
                isCalledFromHomeScreen: false,
              ),
          ScanScreen.id: (context) => const ScanScreen(),
        },
      ),
    );
  }
}
