import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../../constants.dart';
import '../../global_components/wemo_button.dart';

class VerificationSuccessScreen extends StatefulWidget {
  static const id = "verification success";

  final VoidCallback navigateToNextPage;
  final VoidCallback navigateToPreviousPage;
  const VerificationSuccessScreen(
      {Key? key,
      required this.navigateToNextPage,
      required this.navigateToPreviousPage})
      : super(key: key);

  @override
  State<VerificationSuccessScreen> createState() =>
      _VerificationSuccessScreenState();
}

class _VerificationSuccessScreenState extends State<VerificationSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height * .6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Number Verified",
              style: Theme.of(context).textTheme.headline1,
            ),
            const Spacer(),
            Image(
              image: const AssetImage("assets/images/verification_success.png"),
              width: screenSize.width * .75,
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

                  ///Add number when verification is successful
                  widget.navigateToNextPage();
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
