import 'package:flutter/material.dart';
import 'package:wemo/screens/initialsetupflowscreens/verification_success_screen.dart';
import 'package:wemo/screens/initialsetupflowscreens/verify_num_screen.dart';

import 'show_qr_screen.dart';

class WemoBottomSheets extends StatefulWidget {
  const WemoBottomSheets({Key? key}) : super(key: key);

  @override
  State<WemoBottomSheets> createState() => _WemoBottomSheetsState();
}

class _WemoBottomSheetsState extends State<WemoBottomSheets> {
  PageController pageController = PageController();
  int currentView = 0;
  List<Widget> pages = [
    const VerifyNumberScreen(),
    const VerificationSuccessScreen(),
    const ShowQRCodeScreen(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView.builder(
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
    );
  }
}
