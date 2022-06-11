import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:wemo/constants.dart';
import 'package:wemo/global_components/wemo_snackbar.dart';
import 'package:wemo/screens/sendscreen/send_dialog_screen.dart';

import '../onboardingscreen/components/round_button.dart';

class ScanScreen extends StatefulWidget {
  static const id = "scan screen";
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");
  String flashIconLInk = "assets/svg/flash_on_icon.svg";
  bool flashOn = false;

  ///-------------Adding Mobile Scanner Package ---------///
  MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
              controller: cameraController,
              allowDuplicates: false,
              onDetect: (
                Barcode barcode,
                MobileScannerArguments? args,
              ) {
                if (barcode.rawValue == null) {
                  debugPrint("Failed to scan QR");
                  wemoSnackBar(context,
                      message: "Failed to Scan Code", isSuccess: false);
                } else {
                  ///Take the result and split into the name and number
                  final String resultCode = barcode.rawValue!;
                  HapticFeedback.heavyImpact();
                  Navigator.pop(context);
                  String receiverNumber = resultCode.substring(0, 9);
                  //number will never be null because of the if check

                  String receiverName = resultCode.substring(9);

                  ///Showing the Popup when it scans the QR
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SendDialogScreen(
                          receiverName: receiverName,
                          receiverNumber: receiverNumber,
                          isSendingthroughNumber: false,
                        );
                      });
                }
              }),
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding2x * 3),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(
                iconLink: flashOn
                    ? "assets/svg/flash_on_icon.svg"
                    : "assets/svg/flash_off_icon.svg",
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  cameraController.toggleTorch();

                  setState(() {
                    flashOn = !flashOn;
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: kDefaultPadding, top: kDefaultPadding2x),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(
                  "assets/svg/back_icon.svg",
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultPadding2x),
                border:
                    Border.all(color: Theme.of(context).primaryColor, width: 3),
              ),
              width: screenSize.width * .7,
              height: screenSize.width * .7,
            ),
          )
        ],
      ),
    );
  }
}
