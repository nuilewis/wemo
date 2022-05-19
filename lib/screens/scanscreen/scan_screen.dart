import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wemo/constants.dart';
import 'package:wemo/screens/sendscreen/send_dialog_screen.dart';

import '../splashscreen/components/round_button.dart';

class ScanScreen extends StatefulWidget {
  static const id = "scan screen";
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: "QR");

  QRViewController? qrViewController;
  Barcode? result;

//We have to pause the camera so hot reload can work
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      qrViewController!.resumeCamera();
    }
  }

  void readQr(QRViewController qrViewController) async {
    if (result != null) {
      qrViewController.pauseCamera();
      debugPrint(result!.code);
      qrViewController.dispose();
    }
  }

  void _onQRViewCreated(QRViewController qrViewController) {
    this.qrViewController = qrViewController;
    qrViewController.scannedDataStream.listen((
      scanData,
    ) {
      setState(() {
        result = scanData;
      });

      if (result?.code != null) {
        qrViewController.pauseCamera();
        debugPrint("scan data result is ${result?.code}");

        HapticFeedback.heavyImpact();
        // ScaffoldMessenger.of(context)
        //     .showSnackBar(SnackBar(content: Text(result?.code ?? "null")));

        ///Take the result and split into the name and number
        String? joinedResultString = result?.code;

        int recieverNumber = int.parse(joinedResultString!.substring(0, 9));
        //number will never be null because of the if check

        String recieverName = joinedResultString.substring(9);

        ///Showing the Popup when it scans the QR

        showDialog(
            context: context,
            builder: (context) {
              return SendDialogScreen(
                recieverName: recieverName,
                recieverNumber: recieverNumber,
              );
            });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    qrViewController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
                borderColor: kPurple,
                borderRadius: 28,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 250),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: kDefaultPadding2x * 3),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButton(
                iconLink: "assets/svg/back_icon.svg",
                onPressed: () {
                  HapticFeedback.lightImpact();
                  Feedback.forTap(context);
                  qrViewController?.toggleFlash();
                  qrViewController?.resumeCamera();
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
        ],
      ),
    );
  }
}
