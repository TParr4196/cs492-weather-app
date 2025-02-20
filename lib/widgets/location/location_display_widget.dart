import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/location/location.dart' as location;

class LocationDisplayWidget extends StatelessWidget {
  const LocationDisplayWidget(
      {super.key, required location.Location? activeLocation})
      : _location = activeLocation;

  final location.Location? _location;

  @override
  Widget build(BuildContext context) {
    return Text(_location != null
        ? "${_location.city}, ${_location.state} ${_location.zip}"
        : "No Location Set");
  }
}
