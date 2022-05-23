import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wemo/global_components/wemo_button.dart';
import 'package:wemo/services/transaction_service.dart';
import '../../constants.dart';
import '../../providers/send_money_provider.dart';

class InputAmountAndPinDialog extends StatefulWidget {
  final String? recieverName;
  final String? receiverNumber;
  final bool? isSendingThroughNumber;
  final Function navigateToNextPage;
  const InputAmountAndPinDialog({
    Key? key,
    this.recieverName,
    this.receiverNumber,
    required this.navigateToNextPage,
    required this.isSendingThroughNumber,
  }) : super(key: key);

  @override
  State<InputAmountAndPinDialog> createState() =>
      _InputAmountAndPinDialogState();
}

class _InputAmountAndPinDialogState extends State<InputAmountAndPinDialog> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: "send money form key");
  final Key amountKey = GlobalKey();
  final Key pinKey = GlobalKey();
  final Key numberKey = GlobalKey();

  bool addCharges = false;

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    pinController.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SendMoneyData>(
      builder: (context, sendMoneyData, child) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: kDefaultPadding,
                ),

                ///Add number field
                ///If the user is sending through number, then show an extra
                ///text form field to add the number
                widget.isSendingThroughNumber!
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Number",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            key: numberKey,
                            maxLength: 9,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20),
                            keyboardType: TextInputType.number,
                            controller: numberController,
                            decoration: wemoTextFieldDecoration.copyWith(
                                hintText: "Number"),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "0") {
                                return "Please the number to send to";
                              }

                              return null;
                            },
                          ),
                        ],
                      )
                    : const SizedBox(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Amount",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 5),

                TextFormField(
                  key: amountKey,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontSize: 20),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration:
                      wemoTextFieldDecoration.copyWith(hintText: "Amount"),
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "0") {
                      return "Please enter an Amount";
                    }

                    return null;
                  },
                ),
                const SizedBox(height: kDefaultPadding),
                widget.isSendingThroughNumber!
                    ? const SizedBox()
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "PIN Code",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                const SizedBox(
                  height: 5,
                ),

                ///Pin Field
                widget.isSendingThroughNumber!
                    ? const SizedBox()
                    : TextFormField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        key: pinKey,
                        maxLength: 5,
                        keyboardType: TextInputType.number,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 20),
                        controller: pinController,
                        decoration:
                            wemoTextFieldDecoration.copyWith(hintText: "PIN"),
                        validator: (value) {
                          if (value!.length < 4 ||
                              value == null ||
                              value.isEmpty) {
                            return "Please enter a valid PIN";
                          }
                          return null;
                        },
                      ),
                const SizedBox(
                  height: kDefaultPadding - 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Add Withdrawal Charges?",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    CupertinoSwitch(
                      value: addCharges,
                      activeColor: kPurple,
                      trackColor: kDark20,
                      thumbColor: Colors.white,
                      onChanged: (bool value) {
                        HapticFeedback.lightImpact();
                        Feedback.forTap(context);
                        setState(() {
                          addCharges = value;
                        });
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                WemoButton(
                  isSmall: true,
                  textColor: Colors.white,
                  title: "Send",
                  showIcon: true,
                  iconLink: "assets/svg/send_icon.svg",
                  onPressed: () {
                    int? amount = int.tryParse(amountController.text);

                    if (_formKey.currentState!.validate()) {
                      ///If text inputs are valid, then process with the following logic

                      HapticFeedback.lightImpact();
                      Feedback.forTap(context);

                      ////Take values from text controllers and assign it to the variables to send.

                      ///These values will actually never be nullable because the text validator will check first

                      ///adding all details of the person we are sending money to to the provider
                      sendMoneyData.sendMoneyToPerson(
                        amount: addCharges
                            ? TransactionService.calculateCharges(amount!)
                            : amount!,
                        pin: pinController.text,
                        name: widget.isSendingThroughNumber!
                            ? ""
                            : widget.recieverName!,

                        number: widget.isSendingThroughNumber!
                            ? numberController.text
                            : widget.receiverNumber.toString(),

                        ///If the user is not sending through qr, then take the inputted number and use. and
                        ///also set the name to null bcs we cannot get the name.
                      );

                      ///Now Navigate to the next confirmation dialog
                      widget.navigateToNextPage();
                    }
                  },
                ),
                const SizedBox(
                  height: kDefaultPadding,
                ),
                WemoButton(
                  isSmall: true,
                  isSecondary: true,
                  title: "Cancel",
                  showIcon: false,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Feedback.forTap(context);
                    Navigator.pop(context);

                    ///Todo: pop the dialog
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
