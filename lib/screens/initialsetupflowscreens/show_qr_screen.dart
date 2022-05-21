import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wemo/providers/momo_num_provider.dart';
import 'package:wemo/screens/homescreen/homescreen.dart';
import 'package:wemo/screens/recievescreen/components/show_qr.dart';
import 'package:wemo/services/qr_service.dart';
import '../../constants.dart';
import '../../global_components/wemo_button.dart';

class ShowQRCodeScreen extends StatefulWidget {
  static const id = "verification success";
  final int? index;

  final VoidCallback? navigateToNextPage;
  final VoidCallback? navigateToPreviousPage;
  final bool? isCalledFromHomeScreen;
  final bool? onRecievedTapped;

  const ShowQRCodeScreen({
    Key? key,
    this.index,
    this.navigateToNextPage,
    this.navigateToPreviousPage,
    this.onRecievedTapped = false,
    this.isCalledFromHomeScreen = false,
  }) : super(key: key);

  @override
  State<ShowQRCodeScreen> createState() => _ShowQRCodeScreenState();
}

class _ShowQRCodeScreenState extends State<ShowQRCodeScreen> {
  int? index;

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  ///setting index to zero so it will get the first number in the list of numbers since this will be the first
  ///time the user is setting up, so there will only be one number.
  ///but we allow the index to be changeable by putting it in a variable so if the user adds more numbers, we can find the
  ///specific number by looking at its index.

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<MomoNumberData>(builder: (context, momoNumData, child) {
      //if an index is not provided, then show the last

      index ??=
          momoNumData.momoNumberList.indexOf(momoNumData.momoNumberList.last);
      return Container(
        height: widget.onRecievedTapped!
            ? screenSize.height * .65
            : screenSize.height * .75,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(kDefaultPadding2x),
            topLeft: Radius.circular(kDefaultPadding2x),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                "Here's your Wemo Code",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ShowQRCode(
                data: QrService().joinNameNUmber(
                    number: momoNumData.momoNumberList[index!].number,
                    name: momoNumData.momoNumberList[index!].name),
              ),
              const SizedBox(height: kDefaultPadding),
              Text(
                momoNumData.momoNumberList[index!].name,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: kPurple),
              ),
              Text(
                momoNumData.momoNumberList[index!].number.toString(),
                style: Theme.of(context).textTheme.headline2,
              ),
              const Spacer(
                flex: 2,
              ),
              widget.onRecievedTapped!
                  ? const SizedBox()
                  : WemoButton(
                      textColor: Colors.white,
                      title: "Save",
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        Feedback.forTap(context);

                        ///Todo: add methods to print to PDF.
                        ///
                        if (widget.isCalledFromHomeScreen == true) {
                          debugPrint(
                              "qr screen is popping until to return to homescreen");
                          Navigator.popUntil(
                              context, ModalRoute.withName(HomeScreen.id));

                          /// of the bottom sheet was called from the homescreen ie the user added a number,
                          /// then instead of pushing a new homescreen over the old homescreen, rather pop the current
                          /// bottomsheet plus the underlying add number page.
                        } else {
                          debugPrint("qr screen is pushing homescreen");
                          Navigator.popAndPushNamed(context, HomeScreen.id);

                          ///In this case, the bottom sheet was called from the initial setup/splash screen
                          ///therefore no homesceen has been called to the navigator stack, and popping both pages as done
                          ///above will result to a black screen being displayed, to prevent this, this section
                          ///will rather push to the homescreen.
                        }
                      }),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      );
    });
  }
}
