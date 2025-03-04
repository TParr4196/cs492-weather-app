import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/scripts/time.dart' as time;
import 'package:weatherapp/scripts/math.dart' as math;

// TODO: Add the icon to this widget as well
// Make it look good.

class ForecastWidget extends StatelessWidget {
  const ForecastWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ForecastNameWidget(forecast: _forecast),
            Text(_forecast.detailedForecast ?? _forecast.shortForecast),
            Text("Wind: ${_forecast.windSpeed} ${_forecast.windDirection}"),
            Text("Temp: ${_forecast.temperature}°${_forecast.temperatureUnit}"),
            Text(_forecast.dewpoint != null ? "Dewpoint: ${math.roundToDecimalPlaces(_forecast.dewpoint, 2)}" : ""),
            Text(_forecast.humidity != null ? "Humidity: ${_forecast.humidity}" : ""),
            Text(_forecast.precipitationProbability != null ? "Chance of Rain: ${_forecast.precipitationProbability}" : ""),
          ],
        ),
      ),
    );
  }
}

class ForecastNameWidget extends StatelessWidget {
  const ForecastNameWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Text(
      _forecast.name ?? time.convertTimestampToDayAndHour(_forecast.startTime),
      style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold)
    );
  }
}
