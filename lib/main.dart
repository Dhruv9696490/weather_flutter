import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/WeatherViewModel.dart';
import 'WeatherHome.dart';

void main(){
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_){
        return WeatherViewModel();
      })
    ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Simple Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3:  true),
      home: const WeatherHome(),
    );
  }
}

