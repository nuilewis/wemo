import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:wemo/constants.dart';
import 'package:wemo/global_components/wemo_button_small.dart';
import 'package:wemo/providers/momo_num_provider.dart';
import 'package:wemo/providers/transaction_provider.dart';
import 'package:wemo/screens/initialsetupflowscreens/addnumberscreen.dart';
import 'package:wemo/screens/initialsetupflowscreens/show_qr_screen.dart';
import 'package:wemo/screens/scanscreen/scan_screen.dart';
import '../../models/momo_num_model.dart';

import 'components/add_number_button.dart';
import 'components/phone_num_card.dart';

class HomeScreen extends StatefulWidget {
  static const id = "homescreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer2<MomoNumberData, TransactionData>(
      builder: (context, momoNumData, transactionData, child) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            body: Stack(
              children: [
                // SizedBox(
                //   height: screenSize.height,
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: kDefaultPadding2x * 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding2x),
                      child: Text(
                        "Welcome Back!",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),

                    ///Phone Numbers
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(
                            width: kDefaultPadding,
                            height: 190,
                          ),
                          SizedBox(
                            ///Use the sizebox to contrain the height of the List view

                            height: 120,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: momoNumData.momoNumberList.length,
                              shrinkWrap: true,
                              itemExtent: screenSize.width * .75,
                              itemBuilder: (context, index) {
                                ///Setting the current index so that
                                currentIndex = index;
                                print(currentIndex);

                                List<MomoNumber> momoNumbersList =
                                    momoNumData.momoNumberList;

                                return PhoneNumberCard(
                                    number: momoNumbersList[index]
                                        .number
                                        .toString(),
                                    name: momoNumbersList[index].name,
                                    network: momoNumbersList[index]
                                        .network
                                        .toString()
                                        .toUpperCase());
                              },
                            ),
                          ),
                          AddNumberButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Feedback.forTap(context);

                              Navigator.pushNamed(context, AddNumberScreen.id);
                            },
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding2x),
                      child: Text(
                        "History",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding2x),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: WemoButtonSmall(
                            textColor: Colors.white,
                            title: "Send",
                            showIcon: true,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Feedback.forTap(context);
                              Navigator.pushNamed(context, ScanScreen.id);
                            },
                            iconLink: "assets/svg/send_icon.svg",
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                        Expanded(
                          child: WemoButtonSmall(
                            textColor: Colors.white,
                            title: "Receive",
                            showIcon: true,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Feedback.forTap(context);

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) =>
                                      ShowQRCodeScreen(index: currentIndex));
                            },
                            iconLink: "assets/svg/received_icon.svg",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
