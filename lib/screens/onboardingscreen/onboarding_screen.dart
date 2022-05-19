import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wemo/constants.dart';
import 'package:wemo/screens/initialsetupflowscreens/addnumberscreen.dart';
import 'components/round_button.dart';

class OnboardingScreen extends StatelessWidget {
  static const id = "splash screen";
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/svg/thick_purple_blob_1.svg",
              width: screenSize.width * .4,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SvgPicture.asset(
              "assets/svg/light_purple_blob_1.svg",
              width: screenSize.width * .35,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding2x),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(
                  flex: 2,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/intro_illus.png",
                    width: screenSize.width * .75,
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Simplify your \nMoMo transactions with",
                        style: Theme.of(context).textTheme.headline1),
                    TextSpan(
                        text: " Wemo",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: kPurple)),
                  ]),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: RoundedButton(
                    iconLink: "assets/svg/forward_icon.svg",
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Feedback.forTap(context);
                      Navigator.pushNamed(context, AddNumberScreen.id);
                    },
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
