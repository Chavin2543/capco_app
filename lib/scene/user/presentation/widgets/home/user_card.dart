import 'package:capco_app/base/color/colours.dart';
import 'package:capco_app/base/constants/local/local_constants.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {required this.username,
      required this.email,
      required this.onTap,
      Key? key})
      : super(key: key);

  final String username;
  final String email;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(spacingSixteen),
        decoration: const BoxDecoration(
          color: Colours.arsenic,
          borderRadius: BorderRadius.all(
            Radius.circular(radiusSixteen),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radiusTwenty),
                color: Colours.emerald,
              ),
              child: Center(
                child: Text(
                  username[0],
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
            const SizedBox(width: spacingSixteen),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: spacingFour),
                Text(email),
              ],
            )
          ],
        ),
      ),
    );
  }
}
