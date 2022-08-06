import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wemo/services/url_service.dart';
import 'package:wemo/constants.dart';

class WemoDrawer extends Drawer {
  const WemoDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Drawer(
      width: screenSize.width * .75,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //shrinkWrap: true,
        children: [
          const SizedBox(height: kDefaultPadding2x*2 ),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              "assets/svg/wemo_logo.svg",
              height: 50,
              color: Theme.of(context).primaryColor
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          
          ListTile(
            horizontalTitleGap: 0,
            leading: SvgPicture.asset(
              "assets/svg/privacy_policy_icon.svg",
              color: Theme.of(context).primaryColor
            ),
            trailing: SvgPicture.asset(
              "assets/svg/external_link_icon.svg",
              color: Theme.of(context).iconTheme.color!.withOpacity(.3),
            ),
            onTap: () {
              HapticFeedback.lightImpact();
              Feedback.forTap(context);
              UrlService().navToPrivacyPolicy(Uri(
                  scheme: "https",
                  host: "wemoapp.net",
                  path: "privacy-policy"));
            },
            enableFeedback: true,
            selectedTileColor: Theme.of(context).primaryColor,
            title: Text(
              "Privacy Policy",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
            ),
          ),
          const Spacer(flex: 2,),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Wemo Version $versionNumber",
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: kDefaultPadding2x)
        ],
      ),
    );
  }
}
