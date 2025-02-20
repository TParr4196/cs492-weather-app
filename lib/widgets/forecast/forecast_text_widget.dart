import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/scripts/math.dart' as math;

class ForecastTextWidget extends StatelessWidget{
  const ForecastTextWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            Text(_forecast.shortForecast),
            Text("Wind: ${_forecast.windSpeed} ${_forecast.windDirection}"),
            Text("Temp: ${_forecast.temperature}°${_forecast.temperatureUnit}"),
            Text(_forecast.dewpoint != null ? "Dewpoint: ${math.roundToDecimalPlaces(_forecast.dewpoint, 2)}" : ""),
            Text(_forecast.humidity != null ? "Humidity: ${_forecast.humidity}" : ""),
            Text(_forecast.precipitationProbability != null ? "Chance of Rain: ${_forecast.precipitationProbability}" : "")
            ]
      );
  }
}
