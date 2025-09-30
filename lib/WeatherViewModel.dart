
import 'package:flutter/cupertino.dart';
import 'package:weather_flutter/NewsData.dart';
import 'package:weather_flutter/WeatherApi.dart';

class WeatherViewModel extends ChangeNotifier{
  final WeatherApi _weatherApi = WeatherApi();
  //i make it final
    WeatherData _weatherData = WeatherData();
  WeatherData get weatherData => _weatherData;
   bool _loading = false;
  bool get loading => _loading;
   String _error = "";
  String get error => _error;
  Future<void> getAllData(String city)async{
    _loading=true;
    notifyListeners();
    try{
      _weatherData = await _weatherApi.getData(city);
    }catch(e){
      _error = e.toString() ;
    }
    _loading=false;
    notifyListeners();

  }
}