import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/widgets/forecast/detailed_forecast_widget.dart';
import 'package:weatherapp/widgets/forecast/forecast_name_widget.dart';
import 'package:weatherapp/widgets/forecast/forecast_text_widget.dart';
import 'package:weatherapp/widgets/forecast/weather_icon_widget.dart';

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
            WeatherIconWidget(iconPath: _forecast.getIconPath(), height: 100, width: 100),
            ForecastTextWidget(forecast: _forecast),
            DetailedForecastWidget(forecast: _forecast)
          ],
        ),
      ),
    );
  }
}
