import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wemo/providers/number_provider.dart';

import '../../constants.dart';
import '../../global_components/wemo_button.dart';
import '../verificationscreens/verify_number.dart';

class AddNumberScreen extends StatefulWidget {
  static const id = "add a number";
  const AddNumberScreen({Key? key}) : super(key: key);

  @override
  State<AddNumberScreen> createState() => _AddNumberScreenState();
}

class _AddNumberScreenState extends State<AddNumberScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    number.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<MomoNumberData>(
      builder: (context, momoNumData, child) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: SvgPicture.asset(
                  "assets/svg/thick_purple_blob_2.svg",
                  width: screenSize.width * .4,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SvgPicture.asset(
                  "assets/svg/light_purple_blob_2.svg",
                  width: screenSize.width * .35,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding2x),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    const Spacer(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Add a Number",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: kPurple),
                      ),
                    ),
                    const Spacer(),
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18),
                      keyboardType: TextInputType.text,
                      decoration: wemoTextFieldDecoration.copyWith(
                          hintText: "Momo Name"),
                    ),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    TextFormField(
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 18),
                      keyboardType: TextInputType.number,
                      decoration: wemoTextFieldDecoration.copyWith(
                          hintText: "Phone Number"),
                    ),
                    const Spacer(flex: 2),
                    WemoButton(
                      textColor: Colors.white,
                      title: "Send Verification SMS",
                      onPressed: () {
                        Feedback.forTap(context);
                        HapticFeedback.lightImpact();

                        // momoNumData.addMomoNUmber(
                        //     name: name.text, number: number.text);
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const VerifyNumber());
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
