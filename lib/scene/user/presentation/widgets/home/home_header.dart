import 'package:flutter/material.dart';

import '../../../../../base/color/colours.dart';
import '../../../../../base/constants/local/local_constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spacingTwentyFour),
      child: Row(
        children: [
          const Icon(
            Icons.home_filled,
            color: Colours.lavender,
          ),
          const SizedBox(width: spacingSixteen),
          Text(
            appName,
            style: Theme
                .of(context)
                .textTheme
                .displayLarge,
          ),
        ],
      ),
    );
  }
}
