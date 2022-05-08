import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:wemo/constants.dart';
import 'package:wemo/providers/number_provider.dart';
import 'package:wemo/screens/initialsetupflowscreens/addnumberscreen.dart';
import 'package:wemo/screens/scanscreen/scan_screen.dart';
import 'package:wemo/services/ussd_service.dart';

import '../../models/momo_num_model.dart';
import '../recievescreen/components/show_qr.dart';
import 'components/phone_num_card.dart';

class HomeScreen extends StatefulWidget {
  static const id = "homescreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<MomoNumberData>(
      builder: (context, momoNumData, child) {
        return Scaffold(
            body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        List<MomoNumber> momoNumbersList =
                            momoNumData.momoNumberList;

                        return PhoneNumberCard(
                            number: momoNumbersList[index].number.toString(),
                            name: momoNumbersList[index].name,
                            network: momoNumbersList[index]
                                .network
                                .toString()
                                .toUpperCase());
                      },
                    ),
                  ),
                  const SizedBox(
                    width: kDefaultPadding,
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

            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScanScreen()));
                },
                child: const Text("ScanQr"))
          ],
        ));
      },
    );
  }
}

class AddNumberButton extends StatelessWidget {
  final VoidCallback onPressed;
  const AddNumberButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          color: kPurple20,
          borderRadius: BorderRadius.circular(kDefaultPadding2x),
        ),
        child: Center(
            child:
                SvgPicture.asset("assets/svg/plus_icon.svg", color: kPurple)),
      ),
    );
  }
}
