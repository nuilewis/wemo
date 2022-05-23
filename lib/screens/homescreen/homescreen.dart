import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wemo/constants.dart';
import 'package:wemo/global_components/wemo_text_title.dart';
import 'package:wemo/global_components/wemo_button.dart';
import 'package:wemo/models/transaction_model.dart';
import 'package:wemo/providers/momo_num_provider.dart';
import 'package:wemo/providers/transaction_provider.dart';
import 'package:wemo/screens/homescreen/components/transaction_card.dart';
import 'package:wemo/screens/initialsetupflowscreens/addnumberscreen.dart';
import 'package:wemo/screens/initialsetupflowscreens/show_qr_screen.dart';
import 'package:wemo/screens/scanscreen/scan_screen.dart';
import 'package:wemo/screens/sendscreen/send_dialog_screen.dart';
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
  final GlobalKey<FormState> addNumberFormKey = GlobalKey<FormState>();
  final Key addNumberNumkey = GlobalKey();
  final Key addNumberNameKey = GlobalKey();

  final PageController pageController = PageController(viewportFraction: .8);
  bool isExpandable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navToScanScreen() {
    HapticFeedback.lightImpact();
    Feedback.forTap(context);
    setState(() {
      isExpandable = !isExpandable;
    });
    Navigator.pushNamed(context, ScanScreen.id);
  }

  void inputNUmber() {
    HapticFeedback.lightImpact();
    Feedback.forTap(context);
    setState(() {
      isExpandable = !isExpandable;
    });
    showDialog(
        context: context,
        builder: (context) {
          return const SendDialogScreen(
            isSendingthroughNumber: true,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer2<MomoNumberData, TransactionData>(
      builder: (context, momoNumData, transactionData, child) {
        momoNumData.getSavedMomoNUmber();
        return WillPopScope(
          onWillPop: () async {
            return false;
            //return true;
          },
          child: Scaffold(
            body: Stack(
              children: [
                // SizedBox(
                //   height: screenSize.height,
                // ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: kDefaultPadding2x * 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: kDefaultPadding2x),
                        child: Text(
                          "Welcome Back!",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),

                      SizedBox(
                        height: 190,
                        width: screenSize.width,
                        child: PageView.builder(
                          //padEnds: false,
                          controller: pageController,
                          //physics:  NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: momoNumData.momoNumberList.length,
                          onPageChanged: (index) {
                            ///Setting the current index so that
                            setState(() {
                              currentIndex = index;
                            });
                            debugPrint("current index is $currentIndex");
                          },
                          itemBuilder: (context, index) {
                            List<MomoNumber> momoNumbersList =
                                momoNumData.momoNumberList;

                            return Center(
                              child: PhoneNumberCard(
                                  number: momoNumbersList[index].number,
                                  name: momoNumbersList[index].name,
                                  network: momoNumbersList[index]
                                      .network
                                      .toString() //convert network type to string
                                      .substring(
                                          12) //remove "NetworkType." from converted string to get actual network
                                      .toUpperCase()),
                            );
                          },
                        ),
                      ),

                      ///Phone Numbers
                      AddNumberButton(
                        onPressed: () {
                          HapticFeedback.lightImpact();
                          Feedback.forTap(context);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddNumberScreen(
                                showBackButton: true,
                                formkey: addNumberFormKey,
                                nameKey: addNumberNameKey,
                                numberKey: addNumberNumkey,
                                isCalledFromHomeScreen: true,
                                //isCalledFromHomeScreen: false,
                              ),
                            ),
                          );
                        },
                      ),

                      ///History
                      Padding(
                        padding: const EdgeInsets.only(left: kDefaultPadding2x),
                        child: Text(
                          "History",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),

                      const SizedBox(
                        height: kDefaultPadding2x,
                      ),
                      transactionData.transactionsList.isEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding2x),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Nothing to see here",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(color: kPurple),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: kDefaultPadding,
                                    ),
                                    Text(
                                      "You haven't done any transactions with this number, once you perform a transaction, it'll appear here.",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      transactionData.transactionsList.length,
                                  itemBuilder: (context, index) {
                                    List<Transaction> transactionList =
                                        transactionData.transactionsList;

                                    return TransactionCard(
                                        amount: transactionList[index]
                                            .amount
                                            .toString(),
                                        number: transactionList[index]
                                            .number
                                            .toString(),
                                        name: transactionList[index]
                                            .name
                                            .toString(),
                                        time: transactionList[index].time,
                                        transactionType: transactionList[index]
                                            .transactionType);
                                  }),
                            )
                    ],
                  ),
                ),
                AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    bottom: isExpandable ? 100 : 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding),
                      child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isExpandable ? 1 : 0,
                          child: ExpandedSendOptions(
                            onNumberPressed: inputNUmber,
                            onScanPressed: navToScanScreen,
                          )),
                    )),
                Padding(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding2x),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      // mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: WemoButton(
                            isSmall: true,
                            textColor: Colors.white,
                            title: "Send",
                            showIcon: true,
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              Feedback.forTap(context);

                              setState(() {
                                isExpandable = !isExpandable;
                              });
                            },
                            iconLink: "assets/svg/received_icon.svg",
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                        Expanded(
                          child: WemoButton(
                            bgColor: kPurple,
                            isSmall: true,
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
                                  builder: (context) {
                                    return ShowQRCodeScreen(
                                      onRecievedTapped: true,
                                      index: currentIndex,
                                    );
                                  });
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

class ExpandedSendOptions extends StatelessWidget {
  final VoidCallback onScanPressed;
  final VoidCallback onNumberPressed;
  const ExpandedSendOptions(
      {Key? key, required this.onScanPressed, required this.onNumberPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding2x),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding + 8),
          color: Colors.white,
          boxShadow: const [BoxShadow(blurRadius: 30, color: kPurple20)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onScanPressed,
            child: const WemoTitle(
              textColor: kPurple80,
              title: "Scan",
              showIcon: true,
              iconLink: "assets/svg/scan_icon.svg",
            ),
          ),
          const SizedBox(height: kDefaultPadding2x),
          GestureDetector(
            onTap: onNumberPressed,
            child: const WemoTitle(
              textColor: kPurple80,
              title: "Input Number",
              showIcon: true,
              iconLink: "assets/svg/rounded_plus_icon.svg",
            ),
          ),
        ],
      ),
    );
  }
}
