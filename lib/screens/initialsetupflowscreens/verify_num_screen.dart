import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import '../../global_components/wemo_button.dart';

class VerifyNumberScreen extends StatefulWidget {
  static const id = "verify number";

  final VoidCallback navigateToNextPage;
  final VoidCallback navigateToPreviousPage;
  const VerifyNumberScreen(
      {Key? key,
      required this.navigateToNextPage,
      required this.navigateToPreviousPage})
      : super(key: key);

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
    return SizedBox(
      height: screenSize.height * .6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    .copyWith(color: Theme.of(context).primaryColor),
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
              const Spacer(
                flex: 2,
              ),
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

                      ///TODO: add method to verify phone number eventually
                      widget.navigateToNextPage();
                      //Navigate to next page if verification is complete
                    }
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
