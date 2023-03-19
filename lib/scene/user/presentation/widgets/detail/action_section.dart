import 'package:capco_app/base/constants/local/local_constants.dart';
import 'package:flutter/material.dart';

import '../../../../../base/color/colours.dart';

class ActionSection extends StatelessWidget {
  const ActionSection({
    Key? key,
    required this.openUrlLauncher,
    required this.call,
    required this.emailTo,
    required this.openMap,
  }) : super(key: key);

  final VoidCallback openUrlLauncher;
  final VoidCallback call;
  final VoidCallback emailTo;
  final VoidCallback openMap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        spacingTwentyFour,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: spacingTwelve,
        ),
        decoration: BoxDecoration(
          color: Colours.arsenic,
          borderRadius: BorderRadius.circular(radiusTwentyFour),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () => openUrlLauncher(),
              icon: const Icon(
                Icons.web_rounded,
                color: Colours.white,
              ),
            ),
            IconButton(
              onPressed: () => call(),
              icon: const Icon(
                Icons.phone,
                color: Colours.white,
              ),
            ),
            IconButton(
              onPressed: () => emailTo(),
              icon: const Icon(
                Icons.mail,
                color: Colours.white,
              ),
            ),
            IconButton(
              onPressed: () => openMap(),
              icon: const Icon(
                Icons.map,
                color: Colours.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
