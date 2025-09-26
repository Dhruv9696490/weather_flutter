import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'NewsData.dart';

void main(){
  runApp(const MyApp());
}

const String WEATHER_API_KEY = 'b9699552c0e441b7ab7174259252407'; // <-- replace this
const String BASE_URL = 'http://api.weatherapi.com/v1/current.json';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});
  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController();
  bool loading = false;
  String? error;
  WeatherData? weatherData;
Future<void> getAllUpdates(String city) async{
  setState(() {
    loading=true;
  });
  try{
    final response = await http.get(Uri.parse("$BASE_URL?key=$WEATHER_API_KEY&q=$city&aqi=no"));
    if(response.statusCode==200){
      final data = WeatherData.fromJson(jsonDecode(response.body));
      setState(() {
        loading=false;
        weatherData=data;
      });
    }else{
      setState(() {
        loading=false;
        error="${response.statusCode}";
      });
    }
  }catch(e){
    setState(() {
      loading=false;
      error=e.toString();
    });
  }
  _controller.clear();
}

  Widget _buildCard() {
    List<String>? time = weatherData?.current?.lastUpdated.toString().split(" ");
    final image = weatherData?.current?.condition?.icon.toString().replaceAll("64x64", "128x128");
  if(loading) return Center(child: CircularProgressIndicator());
  if(error!=null) return Text(error!);
  if(weatherData==null) return Text("empty list");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
         Row(
           children: [
             Icon(Icons.location_on,size: 50,color: Colors.black,),
             Text("${weatherData?.location?.name} ",style: TextStyle(
                 fontSize: 24,
                 fontWeight: FontWeight.w700,
                 color: Colors.black
             )),
             Text(weatherData?.location?.region ?? 'o',style: TextStyle(
                 fontWeight: FontWeight.w700,
                 color: Colors.black54
             ),textDirection: TextDirection.ltr,),
           ],
         ),
        Text("${weatherData?.current?.tempC.toString()}°C",style: TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
    color: Colors.black54
    )),
        SizedBox(height: 24),
        Transform.scale(scale: 2,child: Image.network("https:$image",scale: 1.5,fit: BoxFit.cover,colorBlendMode: BlendMode.srcATop,)),
        SizedBox(height: 24),
        Text(weatherData?.current?.condition?.text ?? "",style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black54
        )),
                 Card(
                   color: Colors.white30,
                   child: Column(
                     children: [
                       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                       _infoTyle(weatherData?.current?.humidity.toString() ?? '','Humidity'),
                                       _infoTyle(weatherData?.current?.windKph.toString() ?? '','Wind Speed'),
                                    ],),
                                     Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                       _infoTyle(weatherData?.current?.uv.toString() ?? '','UV'),
                                       _infoTyle(weatherData?.current?.precipIn.toString() ?? '','  Precipitation'),
                                    ],),
                               Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                                       _infoTyle(time?[1] ?? '','Time'),
                                       _infoTyle(time?[0] ?? '','Date'),
                                    ],),
                     ],
                   ),
                 ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App'),centerTitle: true,),
      body: SafeArea(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    label: Text("City"),
                    hint: Text("enter city name"),
                    border: OutlineInputBorder()
                  ),
                  onSubmitted: (v){
                    getAllUpdates(v);
                  },
                )),
                SizedBox(width: 10),
                IconButton(onPressed: (){
                  getAllUpdates(_controller.text);
                },
                    icon: Icon(Icons.send))
              ],
            )),
            Expanded(child: _buildCard())
          ]),
      ),
    );
  }
  }

  Widget _infoTyle(String s,String u){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(s,style: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.bold
      ),),
      Text(u,style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        color: Colors.black54
      ))
    ],
  );
  }







































//class WeatherHome extends StatefulWidget {
//   const WeatherHome({super.key});
//   @override
//   State<WeatherHome> createState() => _WeatherHomeState();
// }
//
// class _WeatherHomeState extends State<WeatherHome> {
//   final TextEditingController _controller = TextEditingController();
//   bool _loading = false;
//   String? _error;
//   WeatherData? _weather;
//   Future<void> _fetchWeather(String query) async {
//     setState(() {
//       _loading = true;
//       _error = null;
//     });
//
//     try {
//       final uri = Uri.parse('$BASE_URL?key=$WEATHER_API_KEY&q=$query');
//       final resp = await http.get(uri).timeout(const Duration(seconds: 12));
//       if (resp.statusCode != 200) {
//         setState(() {
//           _error = 'Error: ${resp.statusCode}';
//           _loading = false;
//         });
//         return;
//       }
//       final Map<String, dynamic> jsonMap = jsonDecode(resp.body);
//       setState(() {
//         _weather = WeatherData.fromJson(jsonMap);
//         _loading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//         _loading = false;
//       });
//     }
//     _controller.clear();
//   }
//
//   Widget _buildCard(){
//     if (_loading) return const Center(child: CircularProgressIndicator());
//     if (_error != null) return Center(child: Text(_error!));
//     if (_weather == null) return const SizedBox.shrink();
//
//     final loc = _weather!.location!;
//     final cur = _weather!.current!;
//     final cond = cur.condition!;
//
//     return Card(
//       margin: const EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 6,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(mainAxisSize: MainAxisSize.max,
//             children: [
//           Text('${loc.name}, ${loc.region}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 8),
//           Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//             if (cond.icon != null && cond.icon!.isNotEmpty)
//               Image.network('https:${cond.icon}', width: 64, height: 64),
//             const SizedBox(width: 12),
//             Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text('${cur.tempC?.toStringAsFixed(1)}°C / ${cur.tempF?.toStringAsFixed(1)}°F', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//               Text(cond.text ?? '', style: const TextStyle(fontSize: 16)),
//             ]),
//           ]),
//           const SizedBox(height: 12),
//           Wrap(spacing: 12, runSpacing: 8, alignment: WrapAlignment.center, children: [
//             _infoTile('Feels like', '${cur.feelslikeC?.toStringAsFixed(1)}°C'),
//             _infoTile('Humidity', '${cur.humidity}%'),
//             _infoTile('Wind', '${cur.windKph?.toStringAsFixed(1)} kph ${cur.windDir}'),
//             _infoTile('Pressure', '${cur.pressureMb} mb'),
//             _infoTile('UV', cur.uv?.toStringAsFixed(1)),
//             _infoTile('Visibility', '${cur.visKm?.toStringAsFixed(1)} km'),
//           ]),
//           const SizedBox(height: 12),
//           Text('Last updated: ${cur.lastUpdated ?? ''}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
//         ]),
//       ),
//     );
//   }
//
//   Widget _infoTile(String title, String? value) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//       decoration: BoxDecoration(
//         color: Colors.blue.shade50,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(mainAxisSize: MainAxisSize.min, children: [
//         Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
//         const SizedBox(height: 6),
//         Text(value ?? '-', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
//       ]),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Simple Weather')),
//       body: SafeArea(
//         child: Column(children: [
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Row(children: [
//               Expanded(
//                 child: TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(labelText: 'City / Town / Zip', border: OutlineInputBorder()),
//                   onSubmitted: (v) => _fetchWeather(v),
//                 ),
//               ),
//               const SizedBox(width: 8),
//               ElevatedButton(
//                 onPressed: () => _fetchWeather(_controller.text),
//                 child: const Text('Get'),
//               )
//             ]),
//           ),
//           Expanded(child: SingleChildScrollView(child: _buildCard())),
//         ]),
//       ),
//     );
//   }
// }
//
// /* ---------------------------
//    Data model classes below
//    (based on your JSON, corrected)
//    --------------------------- */