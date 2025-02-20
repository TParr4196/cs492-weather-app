import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/location/location.dart' as location;

class SavedLocationWidget extends StatelessWidget {
  const SavedLocationWidget(
      {super.key,
      required location.Location loc,
      required Function setLocation})
      : _loc = loc,
        _setLocation = setLocation;

  final location.Location _loc;
  final Function _setLocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _setLocation(_loc);
        },
        child: Container(
          margin: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.black, width: 2)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
                width: 250,
                child: Text("${_loc.city}, ${_loc.state} ${_loc.zip}")),
          ),
        ));
  }
}
