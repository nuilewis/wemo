import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            "Privacy Policy",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(
            """ This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You. 

We use Your Personal data to provide and improve the Service. By using the Service, You agree to the collection and use of information in accordance with this Privacy Policy. """,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            " Collecting and Using Your Personal Data ",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            """ Google defines the term 'Collect' as; “transmitting data from your app off a user’s device.”  Google likewise determines the following use cases do not need to be disclosed as collected: 

“On-device access/processing: User data accessed by your app that is only processed locally on the user’s device and not sent off-device does not need to be disclosed.” 

In light of this definition, we at Wemo Inc do not collect any personally identifiable information from our users.  

But we do perform On-Device access/Processing of Personally identifiable information. """,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          Text(
            " Types of Data Accessed/Processed  ",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            "Personal Data  ",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            """While using Our Service, We may ask You to provide Us with certain personally identifiable information that is used to ensure the functionality of our service. Personally identifiable information may include, but is not limited to: 

 """,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          RichText(
            text: const TextSpan(
              children: [
                 TextSpan(text: "Your Full Name "),
                 TextSpan(text: "Phone number"),
                TextSpan(text: "Usage Data")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
