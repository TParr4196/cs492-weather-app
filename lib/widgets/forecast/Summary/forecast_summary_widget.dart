import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/widgets/forecast/Summary/forecast_summary_name_widget.dart';
import 'package:weatherapp/widgets/forecast/weather_icon_widget.dart';


class ForecastSummaryWidget extends StatelessWidget {
  const ForecastSummaryWidget({
    super.key,
    required forecast.Forecast currentForecast
  }) : _forecast = currentForecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 145,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0), // Adjust the radius to control the roundness
          border: Border.all(
            color: Colors.black, // Border color
            width: 2.0, // Border width
          ),
        ),
        padding: EdgeInsets.all(9.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ForecastSummaryNameWidget(forecast: _forecast),
                  WeatherIconWidget(iconPath: _forecast.getIconPath(), width: 50, height: 50)
                ],
              ),
            ),
            Text(_forecast.tempHighLow ?? "${_forecast.temperature}°${_forecast.temperatureUnit}")
          ],
        ),
      ),
    );
  }
}
