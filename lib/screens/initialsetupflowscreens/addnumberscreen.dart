import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wemo/providers/momo_num_provider.dart';
import 'package:wemo/screens/initialsetupflowscreens/bottomsheets.dart';
import '../../constants.dart';
import '../../global_components/wemo_button.dart';
import 'show_qr_screen.dart';
import 'verification_success_screen.dart';
import 'verify_num_screen.dart';

class AddNumberScreen extends StatefulWidget {
  static const id = "add a number";
  final GlobalKey<FormState> formkey;
  final Key nameKey;
  final Key numberKey;
  const AddNumberScreen(
      {Key? key,
      required this.formkey,
      required this.nameKey,
      required this.numberKey})
      : super(key: key);

  @override
  State<AddNumberScreen> createState() => _AddNumberScreenState();
}

class _AddNumberScreenState extends State<AddNumberScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  late final GlobalKey<FormState> _formKey;
  late Key nameKey;
  late Key numberKey;

  @override
  void initState() {
    super.initState();
    _formKey = widget.formkey;
    nameKey = widget.nameKey;
    numberKey = widget.numberKey;
  }

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    number.dispose();
  }

  //method to show the different bottom sheets

  void openSheet(int index) async {
    List<Widget> bottomSheetPages = [
      const VerifyNumberScreen(),
      const VerificationSuccessScreen(),
      const ShowQRCodeScreen(),
    ];
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => bottomSheetPages[index]);
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
                child: Form(
                  key: _formKey,
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
                        key: nameKey,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                        controller: name,
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
                        key: numberKey,
                        maxLength: 9,

                        /// 13 to allow for adding "+237" to the number
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        controller: number,
                        validator: (value) {
                          if (value == null || value.length < 9) {
                            ///if number is not avalid phone number, then make the form field red

                            return "Please enter a valid phone number.";
                          }
                          return null;
                        },
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

                          ///Validate the input-ted values if they are valid
                          if (_formKey.currentState!.validate()) {
                            //If all the form are validated, then proceed with the rest of the logic

                            momoNumData.addMomoNUmber(
                                name: name.text.toUpperCase(),
                                number: number.text);
                            showModalBottomSheet(
                                isDismissible: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => const ShowQRCodeScreen());
                            // openSheet(2);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
