import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wemo/providers/number_provider.dart';
import 'package:wemo/screens/homescreen/homescreen.dart';
import 'package:wemo/screens/recievescreen/components/show_qr.dart';
import 'package:wemo/services/qr_service.dart';
import '../../constants.dart';
import '../../global_components/wemo_button.dart';

class ShowQRCodeScreen extends StatefulWidget {
  static const id = "verification success";
  final int? index;
  const ShowQRCodeScreen({Key? key, this.index}) : super(key: key);

  @override
  State<ShowQRCodeScreen> createState() => _ShowQRCodeScreenState();
}

class _ShowQRCodeScreenState extends State<ShowQRCodeScreen> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index ?? 0;
  }

  ///setting index to zero so it will get the first number in the list of numbers since this will be the first
  ///time the user is setting up, so there will only be one number.
  ///but we allow the index to be changeable by putting it in a variable so if the user adds more numbers, we can find the
  ///specific number by looking at its index.

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<MomoNumberData>(builder: (context, phoneNumData, child) {
      return Container(
        height: screenSize.height * .9,
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            )),
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
                "Here's your QR Code",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: kPurple),
              ),
              const Spacer(),
              ShowQRCode(
                  data: QrService().joinNameNUmber(
                      number: phoneNumData.momoNumberList[index].number,
                      name: phoneNumData.momoNumberList[index].name)),
              const Spacer(
                flex: 2,
              ),
              WemoButton(
                textColor: Colors.white,
                  title: "Print to PDF",
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Feedback.forTap(context);

                    ///Todo: add methods to print to PDF.
                    Navigator.popAndPushNamed(context, HomeScreen.id);
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
