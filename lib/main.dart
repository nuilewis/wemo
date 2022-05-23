import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wemo/providers/momo_num_provider.dart';
import 'package:wemo/providers/send_money_provider.dart';
import 'package:wemo/providers/transaction_provider.dart';
import 'package:wemo/screens/homescreen/homescreen.dart';
import 'package:wemo/screens/initialsetupflowscreens/addnumberscreen.dart';
import 'package:wemo/screens/scanscreen/scan_screen.dart';
import 'package:wemo/screens/onboardingscreen/onboarding_screen.dart';
import 'package:wemo/services/shared_prefs/shared_prefs_methods.dart';
import 'package:wemo/theme.dart';

int? startupCount;
String startupCountKey = "startup_count";
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  wemoSharedPrefs = await SharedPreferences.getInstance();
  loadMomoSPData();
  loadTransactionSPData();
  startupCount = wemoSharedPrefs.getInt(startupCountKey);
  await wemoSharedPrefs.setInt(startupCountKey, 1);

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
        initialRoute: startupCount == 0 || startupCount == null
            ? OnboardingScreen.id
            : HomeScreen.id,

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
