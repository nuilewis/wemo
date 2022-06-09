import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wemo/global_components/wemo_button.dart';
import 'package:wemo/services/contact_picker_service.dart';
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
  final TextEditingController refController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: "send money form key");
  final Key amountKey = GlobalKey();
  //final Key pinKey = GlobalKey();
  final Key numberKey = GlobalKey();

  bool addCharges = false;
  String? recieverName;

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    refController.dispose();
    numberController.dispose();
  }

  @override
  void initState() {
    recieverName = widget.recieverName;
    super.initState();
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Number",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  Text(
                                    recieverName ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ],
                              )),
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
                                suffixIcon: IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/svg/contact_icon.svg",
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () async {
                                      HapticFeedback.lightImpact();
                                      Feedback.forTap(context);

                                      Map<String, String?> pickedContact =
                                          await ContactPickerService()
                                              .pickContact();
                                      if (pickedContact["number"] != null) {
                                        setState(() {
                                          numberController.text =
                                              pickedContact["number"]!;
                                          recieverName = pickedContact["name"];
                                        });
                                      }
                                    }),
                                hintText: "Number"),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "0" ||
                                  value.length < 9) {
                                return "Please enter a valid number";
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
                // widget.isSendingThroughNumber!
                //     ? const SizedBox()
                //     : Align(
                //         alignment: Alignment.centerLeft,
                //         child: Text(
                //           "Reference",
                //           style: Theme.of(context).textTheme.bodyText1,
                //         ),
                //       ),
                // const SizedBox(
                //   height: 5,
                // ),

                // ///Ref Field
                // widget.isSendingThroughNumber!
                //     ? const SizedBox()
                //     : TextFormField(
                //         textAlign: TextAlign.center,
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodyText1!
                //             .copyWith(fontSize: 20),
                //         controller: refController,
                //         decoration: wemoTextFieldDecoration.copyWith(
                //             hintText: "Reference"),
                //       ),
                // const SizedBox(
                //   height: kDefaultPadding - 8,
                // ),
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
                      activeColor: Theme.of(context).primaryColor,
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
                  height: kDefaultPadding / 2,
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
                        ref: refController.text,
                        name:
                            widget.isSendingThroughNumber! ? "" : recieverName!,

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
                  height: kDefaultPadding / 2,
                ),

                const SizedBox(
                  height: kDefaultPadding / 2,
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
