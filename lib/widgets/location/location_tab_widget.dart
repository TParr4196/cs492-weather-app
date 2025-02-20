import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/location/location.dart' as location;
import 'package:weatherapp/scripts/location/location_storage.dart' as location_storage;
import 'package:weatherapp/scripts/location/location_database.dart' as location_database;
import 'package:weatherapp/widgets/location/location_display_widget.dart';
import 'package:weatherapp/widgets/location/loction_input_widget.dart';
import 'package:weatherapp/widgets/location/saved_locations_widget.dart';

class LocationTabWidget extends StatefulWidget {
  const LocationTabWidget(
      {super.key,
      required Function setLocation,
      required location.Location? activeLocation})
      : _setLocation = setLocation,
        _location = activeLocation;

  final Function _setLocation;
  final location.Location? _location;

  @override
  State<LocationTabWidget> createState() => _LocationTabWidgetState();
}

class _LocationTabWidgetState extends State<LocationTabWidget> {
  final location_storage.LocationStorage ls = location_storage.LocationStorage();

  List<location.Location> _savedLocations = [];

  late location_database.LocationDatabase _db;

  var _editMode = false;

  void _setLocationFromAddress(String city, String state, String zip) async {
    // set location to null temporarily while it finds a new location
    widget._setLocation(null);
    location.Location currentLocation = await location.getLocationFromAddress(
        city, state, zip) as location.Location;
    widget._setLocation(currentLocation);
    _addLocation(currentLocation);
  }

  void _setLocationFromGps() async {
    // set location to null temporarily while it finds a new location
    widget._setLocation(null);
    location.Location currentLocation = await location.getLocationFromGps();
    widget._setLocation(currentLocation);
    _addLocation(currentLocation);
  }

  void _addLocation(location.Location location) async {
    if (!_savedLocations.contains(location)){
      setState(() {
        _savedLocations.add(location);
      });

      _db.insertLocation(location);
    }

  }

  void _deleteLocation(location.Location location) async {
    setState(() {
      _savedLocations.removeWhere((savedLocation) => savedLocation == location);
    });

    _db.deleteLocation(location);
  }

  @override
  void initState() {
    // Get initial locations
    super.initState();
    _loadLocations();
  }

  void _loadLocations() async {
    _db = await location_database.LocationDatabase.open();
    List<location.Location> locations = await _db.getLocations();
    setState(() {
      _savedLocations = locations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LocationDisplayWidget(activeLocation: widget._location),
        LoctionInputWidget(
            setLocation: _setLocationFromAddress), // pass in _addLocation
        ElevatedButton(
            onPressed: () => {_setLocationFromGps()},
            child: const Text("Get From GPS")),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Edit Saved Locations: "),
            Switch(
                value: _editMode,
                onChanged: (bool value) {
                  setState(() {
                    _editMode = value;
                  });
                }),
          ],
        ),
        SavedLocationsWidget(
            locations: _savedLocations,
            setLocation: widget._setLocation,
            editMode: _editMode,
            deleteLocation: _deleteLocation)
      ],
    );
  }
}