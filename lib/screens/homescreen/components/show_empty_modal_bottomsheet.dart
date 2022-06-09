import 'package:flutter/material.dart';

import '../../../constants.dart';

class ShowEmptyModalScreen extends StatelessWidget {
  static const id = "empty modal bottomsheet";

  const ShowEmptyModalScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * .25,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(kDefaultPadding2x),
          topLeft: Radius.circular(kDefaultPadding2x),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              "Nothing Here",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(color: kPurple),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: kDefaultPadding),
            Text(
              "Add a number to receive transactions",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
