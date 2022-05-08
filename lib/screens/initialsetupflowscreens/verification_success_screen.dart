import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../global_components/wemo_button.dart';

class VerificationSuccessScreen extends StatefulWidget {
  static const id = "verification success";
  const VerificationSuccessScreen({Key? key}) : super(key: key);

  @override
  State<VerificationSuccessScreen> createState() => _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        height: screenSize.height * .7,
        decoration:  BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius:const BorderRadius.only(
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
                "Number Verified",
                style: Theme.of(context)
                    .textTheme
                    .headline1,),
              const Spacer(),
              Image(
                image: const AssetImage("assets/images/verification_success.png"),
                width: screenSize.width * .8,
              ),
              const Spacer(
                flex: 2,
              ),
              WemoButton(
                textColor: Colors.white,
                  title: "Done",
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Feedback.forTap(context);
    
                    ///Todo: Navigate to show qr page
                  }),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      
    );
  }
}
