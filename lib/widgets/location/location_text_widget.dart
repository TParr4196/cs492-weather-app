import 'package:flutter/material.dart';

class LocationTextWidget extends StatefulWidget {
  const LocationTextWidget(
      {super.key,
      required double width,
      required String text,
      required Function updateText})
      : _width = width,
        _text = text,
        _updateText = updateText;

  final double _width;
  final String _text;
  final Function _updateText;

  @override
  State<LocationTextWidget> createState() => _LocationTextWidgetState();
}


class _LocationTextWidgetState extends State<LocationTextWidget> {
  // controllers
  late TextEditingController _controller;

  // initialize Controllers
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget._width,
      child: TextField(
          controller: _controller,
          onChanged: (value) => {widget._updateText(value)},
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: widget._text)),
    );
  }
}

