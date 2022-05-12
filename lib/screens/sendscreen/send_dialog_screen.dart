import 'package:flutter/material.dart';
import 'package:wemo/constants.dart';
import 'confrim_and_send_dialog.dart';
import 'input_amount_and_pin_dialog.dart';

class SendDialogScreen extends StatefulWidget {
  final String recieverName;
  final int recieverNumber;
  const SendDialogScreen(
      {Key? key, required this.recieverName, required this.recieverNumber})
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
        recieverName: widget.recieverName,
        recievernumber: widget.recieverNumber,
        navigateToNextPage: navigateToNextDialog,
      ),
      const ConfirmAndSendDialog(),
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
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(kDefaultPadding2x),
            color: Theme.of(context).scaffoldBackgroundColor),
        width: screenSize.width * .8,
     height: screenSize.height*.6,
  
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: Material(
          child: PageView.builder(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
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

