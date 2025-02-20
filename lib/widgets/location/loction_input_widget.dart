import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/location/location_text_widget.dart';

class LoctionInputWidget extends StatefulWidget {
  const LoctionInputWidget({
    super.key,
    required Function setLocation,
  }) : _setLocation = setLocation;

  final Function _setLocation;

  @override
  State<LoctionInputWidget> createState() => _LoctionInputWidgetState();
}


class _LoctionInputWidgetState extends State<LoctionInputWidget> {
  // values
  late String _city;
  late String _state;
  late String _zip;

  @override
  void initState() {
    super.initState();
    _city = "";
    _state = "";
    _zip = "";
  }

  // update functions
  void _updateCity(String value) {
    _city = value;
  }

  void _updateState(String value) {
    _state = value;
  }

  void _updateZip(String value) {
    _zip = value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              LocationTextWidget(
                  width: 100, text: "city", updateText: _updateCity),
              LocationTextWidget(
                  width: 75, text: "state", updateText: _updateState),
              LocationTextWidget(
                  width: 100, text: "zip", updateText: _updateZip),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                widget._setLocation(_city, _state, _zip);
              },
              child: Text("Get From Address"))
        ],
      ),
    );
  }
}