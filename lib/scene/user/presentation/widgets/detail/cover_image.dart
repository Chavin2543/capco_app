import 'package:capco_app/base/constants/local/local_constants.dart';
import 'package:flutter/material.dart';
import '../../../../../base/color/colours.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    super.key,
    required this.initial,
  });

  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colours.emerald),
      width: MediaQuery.of(context).size.width,
      height: coverImageHeight,
      child: Center(
        child: Text(
          initial,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}
