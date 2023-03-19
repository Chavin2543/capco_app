import 'dart:io';

import 'package:capco_app/base/constants/local/local_constants.dart';
import 'package:capco_app/base/exceptions/local/local_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class UserLocation extends StatefulWidget {
  const UserLocation({required this.cameraPosition, Key? key})
      : super(key: key);

  final CameraPosition cameraPosition;

  @override
  State<UserLocation> createState() => UserLocationState();
}

class UserLocationState extends State<UserLocation> {
  @override
  Widget build(BuildContext context) {
    // Context-related functions
    void showError(String message) {
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

    return LayoutBuilder(
      builder: (context, size) {
        return SizedBox(
          height: size.maxHeight,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(radiusTwentyFour),
            ),
            child: GoogleMap(
              liteModeEnabled: Platform.isAndroid ? true : false,
              tiltGesturesEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: widget.cameraPosition,
              markers: {
                Marker(
                  position: LatLng(
                    widget.cameraPosition.target.latitude,
                    widget.cameraPosition.target.longitude,
                  ),
                  onTap: () async {
                    try {
                      await openMap(
                        widget.cameraPosition.target.latitude,
                        widget.cameraPosition.target.longitude,
                      );
                    } on MapException catch (exception) {
                      showError(exception.message);
                    }
                  },
                  markerId: MarkerId(
                      "${widget.cameraPosition.target.latitude}${widget.cameraPosition.target.longitude}"),
                )
              },
            ),
          ),
        );
      },
    );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    try {
      Uri uri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw const MapException();
      }
    } on Exception {
      throw const MapException();
    }
  }
}
