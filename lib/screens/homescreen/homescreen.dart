import 'package:flutter/material.dart';
import 'package:wemo/constants.dart';

class HomeScreen extends StatefulWidget {
  static const id = "homesceen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
          child: (Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                      colors: [kPurple, kPurple60],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
              width: screenSize.width * .7,
            ),
          )
        ],
      ))),
    );
  }
}
