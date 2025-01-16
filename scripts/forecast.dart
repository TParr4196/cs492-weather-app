import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Forecast{
  final String? name;
  final bool isDaytime;
  final int temperature;
  final String temperatureUnit;
  final String windSpeed;
  final String windDirection;
  final String shortForecast;
  final String detailedForecast;
  final int? precipitationProbability;
  final int? humidity;
  final num? dewpoint;

  Forecast({
    required this.name,
    required this.isDaytime,
    required this.temperature,
    required this.temperatureUnit,
    required this.windSpeed,
    required this.windDirection,
    required this.shortForecast,
    required this.detailedForecast,
    required this.precipitationProbability,
    required this.humidity,
    required this.dewpoint,
  });

  factory Forecast.fromJson(Map<String, dynamic> json){
    return Forecast(
      name: json["name"].length > 0? json["name"] : null,
      isDaytime: json["isDaytime"],
      temperature: json["temperature"],
      temperatureUnit: json["temperatureUnit"],
      windSpeed: json["windSpeed"],
      windDirection: json["windDirection"],
      shortForecast: json["shortForecast"],
      detailedForecast: json["detailedForecast"],
      precipitationProbability: json["probabilityOfPrecipitation"]["value"],
      humidity: json["relativeHumidity"] != null ? json["relativeHumidity"]["value"] : null,
      dewpoint: json["dewpoint"]?["value"],
    );
  }

  @override
  String toString(){
    return "name: ${(name != null) ? name : "None"}\n"
      "isDaytime: ${isDaytime ? "Yes" : "No"}\n"
      "Temperature: $temperature $temperatureUnit\n"
      "Wind Speed: $windSpeed\n"
      "Wind Direction: $windDirection\n"
      "Short Forecast: $shortForecast\n"
      "Detailed Forecast: $detailedForecast\n"
      "Chance of Precipitation: $precipitationProbability\n"
      "Humidity: ${(humidity != null) ? humidity : "No Humidity Found"}\n"
      "Dewpoint: $dewpoint";
  }
}

Future<List<Forecast>> getForecastFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecast URL from the response json
  String forecastUrl = pointsJson["properties"]["forecast"];

  // make a request to the forecastJson url and decode the json data
  Map<String, dynamic> forecastJson = await getRequestJson(forecastUrl);
  return processForecasts(forecastJson["properties"]["periods"]);
}

Future<List<Forecast>> getForecastHourlyFromPoints(double lat, double lon) async{
  // make a request to the weather api using the latitude and longitude and decode the json data
  String pointsUrl = "https://api.weather.gov/points/${lat},${lon}";
  Map<String, dynamic> pointsJson = await getRequestJson(pointsUrl);

  // pull the forecastHourly URL from the response json
  String forecastHourlyUrl = pointsJson["properties"]["forecastHourly"];

  // make a request to the forecastHourlyJson url and decode the json data
  Map<String, dynamic> forecastHourlyJson = await getRequestJson(forecastHourlyUrl);
  return processForecasts(forecastHourlyJson["properties"]["periods"]);;
}

List<Forecast> processForecasts(List<dynamic> forecasts){
  List<Forecast> forecastsReturn = [];
  for (dynamic forecast in forecasts){
    Forecast forecastObj = Forecast.fromJson(forecast);
    forecastsReturn.add(forecastObj);
  }
  return forecastsReturn;
}

/*
void processForecast(Map<String, dynamic> forecast){
  String forecastName = forecast["name"];
  bool isDaytime = forecast["isDaytime"];
  int temperature = forecast["temperature"];
  String tempUnit = forecast["temperatureUnit"];
  String windSpeed = forecast["windSpeed"];
  String windDirection = forecast["windDirection"];
  String shortForecast = forecast["shortForecast"];
  String detailedForecast = forecast["detailedForecast"];
  int? preciptationProb = forecast["probabilityOfPrecipitation"]["value"] ?? null;
  int? humidity = forecast["relativeHumidity"] != null ? forecast["relativeHumidity"]["value"] : null;
  num? dewpoint = forecast["dewpoint"]?["value"];

  Forecast forecastObj = Forecast(
    name: forecastName, 
    isDaytime: isDaytime, 
    temperature: temperature, 
    temperatureUnit: tempUnit, 
    windSpeed: windSpeed, 
    windDirection: windDirection, 
    shortForecast: shortForecast, 
    detailedForecast: detailedForecast, 
    precipitationProbability: preciptationProb, 
    humidity: humidity, 
    dewpoint: dewpoint);

  return;
}
*/

Future<Map<String, dynamic>> getRequestJson(String url) async{
  http.Response r = await http.get(Uri.parse(url));
  return convert.jsonDecode(r.body);
}