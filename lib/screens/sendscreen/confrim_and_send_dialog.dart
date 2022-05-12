import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wemo/services/ussd_service.dart';

import '../../constants.dart';
import '../../global_components/wemo_button_small.dart';
import '../../providers/send_money_provider.dart';

class ConfirmAndSendDialog extends StatefulWidget {
  const ConfirmAndSendDialog({Key? key}) : super(key: key);

  @override
  State<ConfirmAndSendDialog> createState() => _ConfirmAndSendDialogState();
}

class _ConfirmAndSendDialogState extends State<ConfirmAndSendDialog> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Consumer<SendMoneyData>(
      builder: (context, sendMoneyData, child) {
        return Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Stack(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/images/send_confirm.png",
                      width: screenSize.width * .4,
                    ),
                    const SizedBox(height: kDefaultPadding),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
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
                            text: " ${sendMoneyData.moneyToSend?.name}",
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
                      ]),
                    ),
                    const SizedBox(height: kDefaultPadding),
                    WemoButtonSmall(
                        textColor: Colors.white,
                        title: "Confirm & Send",
                        showIcon: true,
                        iconLink: "assets/svg/send_icon.svg",
                        onPressed: () async {
                          HapticFeedback.lightImpact();
                          Feedback.forTap(context);

                          ///Dial ussd code
                          // WemoUSSDService().requestUSSD(
                          //   number: sendMoneyData.moneyToSend!.number,
                          //   pin: sendMoneyData.moneyToSend!.pin,
                          //   amount: sendMoneyData.moneyToSend!.amount,
                          // );
                              await WemoUSSDService().requestMtnMomo(
                            number: sendMoneyData.moneyToSend!.number,
                            pin: sendMoneyData.moneyToSend!.pin,
                            amount: sendMoneyData.moneyToSend!.amount,
                          );
                        }),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    WemoButtonSmall(
                      textColor: Colors.white,
                      title: "Cancel",
                      showIcon: false,
                      onPressed: () {
                        ///Todo: pop the dialog
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
