import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../global_components/wemo_button_small.dart';
import '../../providers/send_money_provider.dart';


class InputAmountAndPinDialog extends StatefulWidget {
  final String recieverName;
  final int recievernumber;
  final Function navigateToNextPage;
  const InputAmountAndPinDialog({
    Key? key,
    required this.recieverName,
    required this.recievernumber,
    required this.navigateToNextPage,
  }) : super(key: key);

  @override
  State<InputAmountAndPinDialog> createState() =>
      _InputAmountAndPinDialogState();
}

class _InputAmountAndPinDialogState extends State<InputAmountAndPinDialog> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: "send money form key");
  final Key amountKey = GlobalKey();
  final Key pinKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    pinController.dispose();
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
                const SizedBox(height: kDefaultPadding,),
                    Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Amount",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 5,),
            
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
                      validator:     (value) {
                    if (value == null || value.isEmpty || value =="0" ) {
                      return "Please enter an Amount";
                    }
                    
                    return null;
                  },
                ),
                const SizedBox(height: kDefaultPadding),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "PIN Code",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                const SizedBox(height: 5,),
            
                ///Pin Field
                TextFormField(
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
                  decoration: wemoTextFieldDecoration.copyWith(hintText: "PIN"),
                  validator: (value) {
                    if (value!.length < 4 || value == null || value.isEmpty) {
                      return "Please enter a valid PIN";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: kDefaultPadding2x,),
                WemoButtonSmall(
                  textColor: Colors.white,
                  title: "Send",
                  showIcon: true,
                  iconLink: "assets/svg/send_icon.svg",
                  onPressed: () {
                     int? amount = int.tryParse(amountController.text);
                      int? pin = int.tryParse(pinController.text);
                    if (_formKey.currentState!.validate()) {
                      ///If text inputs are valid, then procedd with the following logic
            
                      HapticFeedback.lightImpact();
                      Feedback.forTap(context);
            
                      ////Take values from text controllers and assign it to the variables to send.
            
            
            
                      ///These values will actually never be nullable because the text validator will check first
            
                      ///adding all details of the person we are sending money to to the provider
                      sendMoneyData.sendMoneyToPerson(
                        amount: amount!,
                        pin: pinController.text,
                        name: widget.recieverName,
                        number: widget.recievernumber.toString(),
                      );
            
                      ///Now Navigate to the next confrimation dialog
                      widget.navigateToNextPage();
                    }
                  },
                ),
                const SizedBox(height: kDefaultPadding,),
                WemoButtonSmall(
                  textColor: Colors.white,
                  title: "Cancel",
                  showIcon: false,
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Feedback.forTap(context);
            
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
