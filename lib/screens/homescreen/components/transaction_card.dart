import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../enums/wemo_enums.dart';

class TransactionCard extends StatefulWidget {
  final String amount;
  final String number;
  final String name;
  final DateTime time;
  final TransactionType transactionType;
  const TransactionCard(
      {Key? key,
      required this.amount,
      required this.number,
      required this.name,
      required this.time,
      required this.transactionType})
      : super(key: key);

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  late TimeOfDay formattedTime;

  @override
  void initState() {
    super.initState();
    formattedTime = TimeOfDay.fromDateTime(widget.time);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: kDefaultPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kDefaultPadding + 8),
      ),
      color: Theme.of(context).cardColor,
      width: double.infinity,
      padding: const EdgeInsets.all(kDefaultPadding),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.amount,
                    style: Theme.of(context).textTheme.headline1),
                TextSpan(
                    text: " FCFA",
                    style: Theme.of(context).textTheme.headline2),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: widget.number,
                    style: Theme.of(context).textTheme.bodyText1),
                TextSpan(
                    text: widget.name,
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SvgPicture.asset(
                (widget.transactionType == TransactionType.sent)
                    ? "assets/svg/send_icon.svg"
                    : "assets/svg/received_icon.svg",
                color: (widget.transactionType == TransactionType.sent)
                    ? kFuchsia
                    : kGreen,
              ),
              Text(
                ///Interpolating the time
                "${widget.time.day} ${monthsOfYear[widget.time.month]} ${widget.time.year} ${formattedTime.format(context)}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: kDark40, fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
