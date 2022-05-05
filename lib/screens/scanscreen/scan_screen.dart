import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wemo/constants.dart';


class ScanScreen extends StatefulWidget {
  const ScanScreen({ Key? key }) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

Barcode? result;
QRViewController? qrViewController;
final GlobalKey qrKey = GlobalKey(debugLabel: "QR");



void _onQRViewCreated( QRViewController qrViewController){

setState(() {
  this.qrViewController = qrViewController;

});

qrViewController.scannedDataStream.listen((scanData) {
  
  setState(() {
    result = scanData;
  });
});

}


//We have to paus the camera so hot reload can work
@override

void reassemble() {
    
    super.reassemble();
    if(Platform.isAndroid){
      qrViewController!.pauseCamera();
    }else if(Platform.isIOS){
      qrViewController!.resumeCamera();
    }
  }


  void readQr() async {

    if(result!=null){
      qrViewController!.pauseCamera();
      print(result!.code);
      qrViewController!.dispose();
    }
  }

  @override
  void dispose() {
  
    super.dispose();
    qrViewController?.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(borderColor: kPurple,
      borderRadius: 28,
      borderLength: 30,
      borderWidth: 10,
      cutOutSize:  250),
      ),
    );
  }
}