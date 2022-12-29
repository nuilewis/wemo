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

class ConfirmAndSendDialog extends StatefulWidget {
  final VoidCallback onBackButtonPressed;
  const ConfirmAndSendDialog({
    Key? key,
    required this.onBackButtonPressed,
  }) : super(key: key);

  @override
  State<ConfirmAndSendDialog> createState() => _ConfirmAndSendDialogState();
}

class _ConfirmAndSendDialogState extends State<ConfirmAndSendDialog> {
  bool isDoingWork = false;
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
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20)),
                        TextSpan(
                            text: " to ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20)),
                        TextSpan(
                            text: sendMoneyData.moneyToSend?.name == ""
                                ? "${sendMoneyData.moneyToSend?.number}"
                                : "${sendMoneyData.moneyToSend?.name} ${sendMoneyData.moneyToSend?.number}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20)),
                        TextSpan(
                            text: " ?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 20)),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultPadding),
                  WemoButton(
                    isDoingWork: isDoingWork,
                    isSmall: true,
                    textColor: Colors.white,
                    title: "Confirm & Send",
                    showIcon: true,
                    iconLink: "assets/svg/send_icon.svg",
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      Feedback.forTap(context);

                      setState(() {
                        isDoingWork = !isDoingWork;
                      });

                      ///Dial ussd code
                      ///

                      WemoUSSDService().requestUSSD(
                        number: sendMoneyData.moneyToSend!.number,
                        ref: sendMoneyData.moneyToSend?.ref,
                        amount: sendMoneyData.moneyToSend!.amount,
                      );
//Add an attempted transaction
                      transactionData.addTransaction(
                        Transaction(
                          name: sendMoneyData.moneyToSend!.name,
                          network: TransactionService.determineNetwork(
                                  sendMoneyData.moneyToSend!.number)
                              .toString(),
                          transactionType: TransactionType.sent.toString(),
                          number: sendMoneyData.moneyToSend!.number,
                          time: DateTime.now().millisecondsSinceEpoch,
                          amount: sendMoneyData.moneyToSend!.amount,
                        ),
                      );

                      ///Also pop the page when you click send

                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  const SizedBox(
                    height: kDefaultPadding,
                  ),
                  WemoButton(
                    isSmall: true,
                    isSecondary: true,
                    title: "Back",
                    showIcon: false,
                    onPressed: widget.onBackButtonPressed,
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
