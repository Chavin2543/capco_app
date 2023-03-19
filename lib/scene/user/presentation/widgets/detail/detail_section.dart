import 'package:capco_app/base/constants/local/local_constants.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/user/user.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: spacingTwentyFour),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(generalInfo, style: Theme.of(context).textTheme.headlineMedium),
          Text(
            user.username + idPrefix + user.id.toString(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            user.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: spacingEight),
          Text(
            businessInfo,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            user.company.name,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            user.company.catchPhrase,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            user.company.bs,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: spacingEight),
          Text(
            addressInfo,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            user.address.suite,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            user.address.street,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            user.address.city,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            user.address.zipcode,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
