import 'package:flutter/material.dart';
import 'package:wemo/screens/initialsetupflowscreens/verification_success_screen.dart';
import 'package:wemo/screens/initialsetupflowscreens/verify_num_screen.dart';

import 'show_qr_screen.dart';

class WemoBottomSheets extends StatefulWidget {
  const WemoBottomSheets({ Key? key }) : super(key: key);

  @override
  State<WemoBottomSheets> createState() => _WemoBottomSheetsState();
}

class _WemoBottomSheetsState extends State<WemoBottomSheets> {

  int currentView = 0;
  List <Widget> pages = [
    const VerifyNumberScreen(),
    const VerificationSuccessScreen(),
    const ShowQRCodeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return pages[currentView];
  }
}