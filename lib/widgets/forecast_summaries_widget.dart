import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/forecast_summary_widget.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;

class ForecastSummaries extends StatelessWidget {
  const ForecastSummaries({
    super.key,
    required List<forecast.Forecast> forecasts,
  }) : _forecasts = forecasts;
  final List<forecast.Forecast> _forecasts;
  
  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView syntax copied from Tristan on 1/28/25 in discord
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [for(forecast.Forecast currentForecast in _forecasts) ForecastSummaryWidget(currentForecast: currentForecast)]),
    );
  }
}