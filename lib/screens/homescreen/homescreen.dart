import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wemo/constants.dart';
import 'package:wemo/global_components/wemo_button.dart';
import 'package:wemo/global_components/wemo_drawer.dart';
import 'package:wemo/models/transaction_model.dart';
import 'package:wemo/providers/momo_num_provider.dart';
import 'package:wemo/providers/transaction_provider.dart';
import 'package:wemo/screens/homescreen/components/show_empty_modal_bottomsheet.dart';
import 'package:wemo/screens/homescreen/components/transaction_card.dart';
import 'package:wemo/screens/initialsetupflowscreens/addnumberscreen.dart';
import 'package:wemo/screens/initialsetupflowscreens/show_qr_screen.dart';
import 'package:wemo/screens/scanscreen/scan_screen.dart';
import 'package:wemo/screens/sendscreen/send_dialog_screen.dart';
import '../../models/momo_num_model.dart';
import 'components/add_number_button.dart';
import 'components/expanded_send_options.dart';
import 'components/phone_num_card.dart';

class HomeScreen extends StatefulWidget {
  static const id = "homescreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final GlobalKey<FormState> addNumberFormKey = GlobalKey<FormState>();
  final Key addNumberNumkey = GlobalKey();
  final Key addNumberNameKey = GlobalKey();

  final PageController pageController = PageController(viewportFraction: .8);
  bool isExpandable = false;
  List<bool> onSelected = [];

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
        transactionData.getSavedTransactions();
        //make all values of onselected false based on the number of items in the list
        for (int i = 0; i < momoNumData.momoNumberList.length; i++) {
          onSelected.add(false);
        }

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
                      const WelcomeTitleAndMenuButton(),

                      momoNumData.momoNumberList.isEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: kDefaultPadding2x,
                                    horizontal: kDefaultPadding2x),
                                child: Text(
                                  "You haven't added a phone number yet, click the button to add one.",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                            )
                          : SizedBox(
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
                                    for (int i = 0;
                                        i < momoNumData.momoNumberList.length;
                                        i++) {
                                      onSelected[i] = false;
                                    }
                                    // onSelected[index] = true;
                                  });
                                  debugPrint("current index is $currentIndex");
                                },
                                itemBuilder: (context, index) {
                                  onSelected[currentIndex] = true;

                                  List<MomoNumber> momoNumbersList =
                                      momoNumData.momoNumberList;

                                  return Center(
                                    child: PhoneNumberCard(
                                      onSelected: onSelected[index],
                                      onDelete: () {
                                        HapticFeedback.lightImpact();
                                        Feedback.forTap(context);
                                        momoNumData.deleteMomoNUmber(context,
                                            index: index);
                                      },
                                      number: momoNumbersList[index].number,
                                      name: momoNumbersList[index].name,
                                      network: momoNumbersList[index]
                                          .network
                                          .toString() //convert network type to string
                                          .substring(
                                              12) //remove "NetworkType." from converted string to get actual network
                                          .toUpperCase(),
                                    ),
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
                        padding: const EdgeInsets.only(
                            left: kDefaultPadding2x, top: kDefaultPadding),
                        child: Text(
                          "Transactions",
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
                                          .copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: kDefaultPadding,
                                    ),
                                    Text(
                                      "You haven't done any transactions yet, once you perform a transaction, it'll appear here.",
                                      style:
                                          Theme.of(context).textTheme.bodyText2,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  transactionData.transactionsList.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                List<Transaction> transactionList =
                                    transactionData.transactionsList.reversed
                                        .toList();

                                return TransactionCard(
                                    onDelete: () {
                                      HapticFeedback.lightImpact();
                                      Feedback.forTap(context);
                                      transactionData.removeTransaction(context,
                                          index: index);
                                    },
                                    amount: transactionList[index]
                                        .amount
                                        .toString(),
                                    number: transactionList[index]
                                        .number
                                        .toString(),
                                    name:
                                        transactionList[index].name.toString(),
                                    time: DateTime.fromMillisecondsSinceEpoch(
                                        transactionList[index].time),
                                    transactionType: transactionList[index]
                                        .transactionType
                                        .toString());
                              }),

                      const SizedBox(height: kDefaultPadding2x * 4),
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
                            iconLink: "assets/svg/send_icon.svg",
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultPadding,
                        ),
                        Expanded(
                          child: WemoButton(
                            bgColor: Theme.of(context).primaryColor,
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
                                    if (momoNumData.momoNumberList.isEmpty) {
                                      return const ShowEmptyModalScreen();
                                    } else {
                                      return ShowQRCodeScreen(
                                        onRecievedTapped: true,
                                        index: currentIndex,
                                      );
                                    }
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
            endDrawer: const WemoDrawer(),
          ),
        );
      },
    );
  }
}

class WelcomeTitleAndMenuButton extends StatelessWidget {
  const WelcomeTitleAndMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
            left: kDefaultPadding2x, right: kDefaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Welcome Back!",
              style: Theme.of(context).textTheme.headline1,
            ),
            IconButton(
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
              icon: SvgPicture.asset("assets/svg/menu_alt_icon.svg"),
            ),
          ],
        ));
  }
}
