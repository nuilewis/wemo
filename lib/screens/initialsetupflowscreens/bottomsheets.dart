import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:wemo/constants.dart';
import 'package:wemo/screens/initialsetupflowscreens/verification_success_screen.dart';
import 'package:wemo/screens/initialsetupflowscreens/verify_num_screen.dart';

import 'show_qr_screen.dart';

class WemoBottomSheets extends StatefulWidget {
  final bool isCalledFromHomeScreen;
  const WemoBottomSheets({Key? key, required this.isCalledFromHomeScreen})
      : super(key: key);

  @override
  State<WemoBottomSheets> createState() => _WemoBottomSheetsState();
}

class _WemoBottomSheetsState extends State<WemoBottomSheets> {
  PageController expandablePageViewController = PageController();
  int currentView = 0;
  late List<Widget> pages;

  @override
  void initState() {
    pages = [
      VerifyNumberScreen(
        navigateToNextPage: navigateToNextSheet,
        navigateToPreviousPage: navigateToPreviousSheet,
      ),
      VerificationSuccessScreen(
        navigateToNextPage: navigateToNextSheet,
        navigateToPreviousPage: navigateToPreviousSheet,
      ),
      ShowQRCodeScreen(
        isCalledFromHomeScreen: widget.isCalledFromHomeScreen,
      ),
    ];

    super.initState();
  }

  @override
  void dispose() {
    expandablePageViewController.dispose();
    super.dispose();
  }

  void navigateToNextSheet() {
    expandablePageViewController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void navigateToPreviousSheet() {
    expandablePageViewController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return AnimatedContainer(
      //  height: screenSize.height * .7,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: kPurple20,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          const SizedBox(height: 25),
          ExpandablePageView.builder(
            //physics: NeverScrollableScrollPhysics(),
            animationDuration: const Duration(milliseconds: 300),
            controller: expandablePageViewController,
            itemBuilder: (context, index) {
              return pages[index];
            },
            itemCount: pages.length,
          ),
        ],
      ),
    );
  }
}
