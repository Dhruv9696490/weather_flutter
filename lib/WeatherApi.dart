
import 'dart:convert';

import 'package:weather_flutter/NewsData.dart';
import 'package:http/http.dart' as http;
class WeatherApi{
  final String weatherUrl = "http://api.weatherapi.com/v1/current.json";
  final String api = "b9699552c0e441b7ab7174259252407";
  // https://api.weatherapi.com/v1/current.json?key=b9699552c0e441b7ab7174259252407&q=London&aqi=no
  Future<WeatherData> getData(String city)async{
    try{
      final urlInstance =await http.get(Uri.parse("$weatherUrl?key=$api&q=$city&aqi=no"));
      if(urlInstance.statusCode==200){
        final response = jsonDecode(urlInstance.body);
        final weatherData = WeatherData.fromJson(response);
        return weatherData;
      }else{
        throw Exception("Something went wrong");
      }
    }catch(e){
      throw Exception("Something went wrong");
    }
  }
}