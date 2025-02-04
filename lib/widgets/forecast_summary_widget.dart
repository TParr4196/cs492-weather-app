import 'package:flutter/material.dart';
import 'package:weatherapp/scripts/forecast.dart' as forecast;
import 'package:weatherapp/scripts/time.dart' as time;

import 'package:flutter_svg/flutter_svg.dart';



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
                  ForecastNameWidget(forecast: _forecast),
                  WeatherIconWidget(iconPath: _forecast.getIconPath(), width: 50.0, height: 50.0,)
                  // ShortForecastWidget(forecast: _forecast)
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

class WeatherIconWidget extends StatelessWidget {
  const WeatherIconWidget({
    super.key,
    required String iconPath,
    required double height,
    required double width
  }) : _iconPath = iconPath, _height = height, _width=width;

  final String _iconPath;
  final double _height;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SvgPicture.asset(_iconPath, height: _height, width: _width),
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
      _forecast.name ?? time.convertTimestampToDayAndHour(_forecast.startTime.toLocal()),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 12.0
      ));
  }
}

class ShortForecastWidget extends StatelessWidget {
  const ShortForecastWidget({
    super.key,
    required forecast.Forecast forecast,
  }) : _forecast = forecast;

  final forecast.Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Text(
      _forecast.shortForecast,
      textAlign: TextAlign.center,
      style:TextStyle(fontSize: 9.0));
  }
}

