import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wemo/enums/wemo_enums.dart';
import 'package:wemo/global_components/wemo_button.dart';
import 'package:wemo/models/transaction_model.dart';
import 'package:wemo/providers/transaction_provider.dart';
import 'package:wemo/services/transaction_service.dart';
import 'package:wemo/services/ussd_service.dart';

import '../../constants.dart';

import '../../providers/send_money_provider.dart';

class ConfirmAndSendDialog extends StatelessWidget {
  const ConfirmAndSendDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Consumer2<SendMoneyData, TransactionData>(
      builder: (context, sendMoneyData, transactionData, child) {
        return Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/send_confirm.png",
                    width: screenSize.width * .4,
                  ),
                  const SizedBox(height: kDefaultPadding),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: " Send",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20)),
                        TextSpan(
                            text: " ${sendMoneyData.moneyToSend?.amount} FCFA",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: kPurple, fontSize: 20)),
                        TextSpan(
                            text: " to",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20)),
                        TextSpan(
                            text:
                                " ${sendMoneyData.moneyToSend?.name == "" ? sendMoneyData.moneyToSend?.number : sendMoneyData.moneyToSend?.name}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: kPurple, fontSize: 20)),
                        TextSpan(
                            text: "?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20)),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  WemoButton(
                    isSmall: true,
                    textColor: Colors.white,
                    title: "Confirm & Send",
                    showIcon: true,
                    iconLink: "assets/svg/send_icon.svg",
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      Feedback.forTap(context);

                      ///Dial ussd code
                      ///

                      // WemoUSSDService().requestUSSD(
                      //   number: sendMoneyData.moneyToSend!.number,
                      //   pin: sendMoneyData.moneyToSend!.pin,
                      //   amount: sendMoneyData.moneyToSend!.amount,
                      // );
                      await WemoUSSDService().requestMtnMomo(
                        context,
                        number: sendMoneyData.moneyToSend!.number,
                        pin: sendMoneyData.moneyToSend!.pin,
                        amount: sendMoneyData.moneyToSend!.amount,
                      );

                      if (transactionData.transactionResult != null) {
                        return;
                      } else if (transactionData.transactionResult!
                          .contains("succesful transfer")) {
                        ///Add a new transaction if the transaction is successful
                        transactionData.addTransaction(
                          Transaction(
                            charges: TransactionService.calculateCharges(
                                    sendMoneyData.moneyToSend!.amount) -
                                sendMoneyData.moneyToSend!.amount,
                            name: sendMoneyData.moneyToSend!.name,
                            network: TransactionService.determinNetwork(
                                    sendMoneyData.moneyToSend!.number)
                                .toString(),
                            transactionType: TransactionType.sent,
                            number: sendMoneyData.moneyToSend!.number,
                            time: DateTime.now(),
                            amount: sendMoneyData.moneyToSend!.amount,
                          ),
                        );
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

                      ///Todo: pop the dialog
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
