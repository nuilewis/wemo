import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class TransactionCard extends StatefulWidget {
  final String amount;
  final String number;
  final String name;
  final DateTime time;
  final String transactionType;
  final VoidCallback onDelete;
  //final String transactionType;
  const TransactionCard(
      {Key? key,
      required this.amount,
      required this.number,
      required this.name,
      required this.time,
      required this.onDelete,
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
      margin: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kDefaultPadding + 8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: kDefaultPadding,
                color: kPurple20.withOpacity(.08),
                offset: const Offset(10, 0)),
          ]),
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
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Theme.of(context).primaryColor)),
                TextSpan(
                    text: " FCFA",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Theme.of(context).primaryColor)),
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
                    text: " ${widget.number} ",
                    style: Theme.of(context).textTheme.bodyText1),
                TextSpan(
                    text: widget.name,
                    style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Row(
            children: [
              SvgPicture.asset(
                (widget.transactionType == "TransactionType.sent")
                    ? "assets/svg/send_icon.svg"
                    : "assets/svg/received_icon.svg",
                color: (widget.transactionType == "TransactionType.sent")
                    ? kFuchsia
                    : kGreen,
              ),
              const SizedBox(width: kDefaultPadding),
              Text(
                ///Interpolating the time
                "${widget.time.day} ${monthsOfYear[widget.time.month]} ${widget.time.year} ${formattedTime.format(context)}",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: kDark40, fontSize: 14),
              ),
              const Spacer(),
              IconButton(
                onPressed: widget.onDelete,
                icon: SvgPicture.asset(
                  "assets/svg/trash_icon.svg",
                  color: kFuchsia,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
