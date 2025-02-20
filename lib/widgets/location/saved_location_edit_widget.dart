import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/location/location.dart' as location;

class SavedLocationEditWidget extends StatelessWidget {
  const SavedLocationEditWidget(
      {super.key,
      required location.Location loc,
      required Function delete})
      : _loc = loc,
        _delete = delete;

  final location.Location _loc;
  final Function _delete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.red, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(width: 250, child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${_loc.city}, ${_loc.state} ${_loc.zip}"),
            GestureDetector(
              onTap: (){_delete(_loc);}, 
              child: Icon(Icons.delete, color: Colors.red))
          ],
        )),
      ),
    );
  }
}
