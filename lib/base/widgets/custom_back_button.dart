import 'package:capco_app/base/color/colours.dart';
import 'package:capco_app/base/constants/local/local_constants.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onBack;

  const CustomBackButton({
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        spacingTwentyFour,
      ),
      child: GestureDetector(
        onTap: () => onBack(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_back_ios,
              color: Colours.white,
            ),
            Text(
              "Back",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
      ),
    );
  }
}
