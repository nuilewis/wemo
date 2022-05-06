import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wemo/constants.dart';
import 'package:wemo/providers/number_provider.dart';
import 'package:wemo/screens/scanscreen/scan_screen.dart';
import 'package:wemo/services/ussd_service.dart';

import '../recievescreen/components/showQR.dart';

class HomeScreen extends StatefulWidget {
  static const id = "homescreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<MomoNumberData>(builder: (context, momoNumData, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
            elevation: 0,
            child: const Icon(
              Icons.call,
              color: Colors.white,
            ),
            onPressed: () {
              WemoUSSDService().requestUSSD("a", "a", "a");
            }),
        body: SingleChildScrollView(
          child: (Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: const LinearGradient(
                          colors: [kPurple, kPurple60],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight)),
                  width: screenSize.width * .8,
                ),
              ),
              ShowQRCode(
                data: "hey guys this si austin",
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScanScreen()));
                  },
                  child: const Text("ScanQr"))
            ],
          )),
        ),
      );
    });
  }
}
