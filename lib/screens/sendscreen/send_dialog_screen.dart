import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:wemo/constants.dart';

import 'confrim_and_send_dialog.dart';
import 'input_amount_and_pin_dialog.dart';

class SendDialogScreen extends StatefulWidget {
  final String? receiverName;
  final String? receiverNumber;
  final bool isSendingthroughNumber;
  const SendDialogScreen(
      {Key? key,
      this.receiverName,
      this.receiverNumber,
      required this.isSendingthroughNumber})
      : super(key: key);

  @override
  State<SendDialogScreen> createState() => _SendDialogScreenState();
}

class _SendDialogScreenState extends State<SendDialogScreen> {
  late final List<Widget> dialogPages;

  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    dialogPages = [
      InputAmountAndPinDialog(
        isSendingThroughNumber: widget.isSendingthroughNumber,
        recieverName: widget.receiverName,
        receiverNumber: widget.receiverNumber,
        navigateToNextPage: navigateToNextDialog,
      ),
      ConfirmAndSendDialog(
        onBackButtonPressed: navigateToPreviousDialog,
      ),
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void navigateToNextDialog() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  void navigateToPreviousDialog() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Center(
      child: AnimatedContainer(
        //   padding: const EdgeInsets.all(kDefaultPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding * 2.5),
            color: Theme.of(context).scaffoldBackgroundColor),
        width: screenSize.width * .8,
        //height: screenSize.height * .6,

        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: Material(
          child: ExpandablePageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dialogPages.length,
            itemBuilder: (context, index) {
              return dialogPages[index];
            },
          ),
        ),
      ),
    );
  }
}
