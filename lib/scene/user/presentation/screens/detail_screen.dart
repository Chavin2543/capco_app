import 'package:capco_app/base/color/colours.dart';
import 'package:capco_app/base/constants/local/local_constants.dart';
import 'package:capco_app/base/exceptions/local/local_exceptions.dart';
import 'package:capco_app/scene/user/domain/entities/user/user.dart';
import 'package:capco_app/scene/user/presentation/widgets/detail/user_location.dart';
import 'package:capco_app/scene/user/presentation/widgets/detail/action_section.dart';
import 'package:capco_app/base/widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../base/constants/network/network_constants.dart';
import '../widgets/detail/cover_image.dart';
import '../widgets/detail/detail_section.dart';

class DetailScreen extends StatelessWidget {
  // Constructor
  const DetailScreen({required this.user, Key? key}) : super(key: key);

  // Properties
  final User user;

  @override
  Widget build(BuildContext context) {
    // Context related Functions
    showError(String message) {
      showDialog(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Text(message),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              )
            ],
          );
        },
      );
    }

    openMap() {
      showModalBottomSheet(
        context: context,
        backgroundColor: Colours.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(radiusTwentyFour),
          ),
        ),
        builder: (context) {
          return UserLocation(
            cameraPosition: CameraPosition(
              target: LatLng(
                double.parse(user.address.geo.lat),
                double.parse(user.address.geo.lng),
              ),
              zoom: 4,
            ),
          );
        },
      );
    }

    // UI
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimationLimiter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(
                  milliseconds: 750,
                ),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: MediaQuery.of(context).size.width,
                  child: widget,
                ),
                children: [
                  CustomBackButton(
                    onBack: () => Navigator.pop(context),
                  ),
                  CoverImage(
                    initial: user.username.characters.first,
                  ),
                  ActionSection(
                      openUrlLauncher: () {
                        try {
                          _openUrlLauncher();
                        } on UrlException catch (error) {
                          showError(error.message);
                        }
                      },
                      call: () async {
                        try {
                          await _call();
                        } on PhoneException catch (error) {
                          showError(error.message);
                        }
                      },
                      emailTo: () async {
                        try {
                          await _emailTo();
                        } on MailException catch (error) {
                          showError(error.message);
                        }
                      },
                      openMap: () => openMap()),
                  DetailSection(
                    user: user,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Non-context related functions
  _openUrlLauncher() async {
    final url = Uri.parse(httpPrefix + user.website);
    if (await canLaunchUrl(url)) {
      try {
        await launchUrl(mode: LaunchMode.externalApplication, url);
      } on Error catch (error) {
        throw UrlException(message: error.toString());
      }
    }
  }

  _call() async {
    try {
      Uri uri = Uri.parse(telPrefix + user.phone);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Error catch (error) {
      throw PhoneException(message: error.toString());
    }
  }

  _emailTo() async {
    try {
      Uri uri = Uri.parse(mailPrefix + user.email);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } on Error catch (error) {
      throw MailException(message: error.toString());
    }
  }
}
