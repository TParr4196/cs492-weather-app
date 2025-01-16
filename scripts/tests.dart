import 'dart:ffi';

import './forecast.dart' as forecast;

Future<void> main() async {
  // testing with Bend, OR coordinates
  Map<String, List<double>> cities = {
    "Bend, OR" : [44.05, -121.31],
    "Birmingham, AL" : [33.5186, -86.8104],
    "Boise, ID" : [43.6150, -116.2023],
    "Babylon, NY" : [40.6958, -73.3257],
    "Boston, MA" : [42.3555, -71.0565],
    "Baltimore, MD" : [39.2904, -76.6122]
  };

  // Create a for loop that will generate forecasts arrays for each city
  cities.forEach((key, value) async {
    List<forecast.Forecast> newfor = await forecast.getForecastFromPoints(value[0], value[1]);
    List<forecast.Forecast> newfor2 = await forecast.getForecastHourlyFromPoints(value[0], value[1]);
  });
}