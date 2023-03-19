import 'package:capco_app/base/color/colours.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingSection extends StatelessWidget {
  const LoadingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Shimmer.fromColors(
        baseColor: Colours.arsenic,
        highlightColor: Colours.lavender,
        child: Image.asset("assets/images/capco_logo.png"),
      ),
    );
  }
}
