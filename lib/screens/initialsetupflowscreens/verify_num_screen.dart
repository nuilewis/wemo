import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import '../../global_components/wemo_button.dart';

class VerifyNumberScreen extends StatefulWidget {
  static const id = "verify number";
  const VerifyNumberScreen({Key? key}) : super(key: key);

  @override
  State<VerifyNumberScreen> createState() => _VerifyNumberScreenState();
}

class _VerifyNumberScreenState extends State<VerifyNumberScreen> {
  final TextEditingController verificationNum = TextEditingController();
  static final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: "verification form key");
  final Key verificationKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    verificationNum.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * .7,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Form(
          key: _formKey,
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
                "Input Verification Code",
                style: Theme.of(context).textTheme.headline1,
              ),
              const Spacer(),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 6) {
                    return "Invalid Verification Code";
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                maxLength: 6,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: verificationNum,
                keyboardType: TextInputType.number,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: kPurple),
                decoration: InputDecoration(
                  errorStyle: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: kFuchsia),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: kFuchsia),
                  ),
                ),
              ),
              const Spacer(),
              WemoButton(
                  textColor: Colors.white,
                  title: "Verify",
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Feedback.forTap(context);
                    // showModalBottomSheet(
                    //     context: context,
                    //     builder: (context) => VerificationSuccessScreen());

                    if (_formKey.currentState!.validate()) {
                      ///If verifcation is valid then proceed to do the following logic
                      Navigator.pop(context);
                    }

                    ///Todo: add method to verify phone number
                  }),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
