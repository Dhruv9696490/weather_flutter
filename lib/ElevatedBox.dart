import 'package:flutter/material.dart';
import 'NewsData.dart';

class ElevatedBox extends StatelessWidget {
  final WeatherData data;
  const ElevatedBox({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${data.current?.tempC}°C",style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                  Image.network("https:${data.current?.condition?.icon}",height: 139,width: 139,fit: BoxFit.cover,),
                  Text("${data.current?.condition?.text}",style: TextStyle(
                    fontSize: 22,
                  ),
                    textAlign: TextAlign.center,),
                  SizedBox(height: 8,),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8,),
        Text(" Weather Forecast",style: TextStyle(
            fontSize: 30
        ),),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _cardBox(title: "Wind Chill",data:  data,semiTitle:  data.current!.windchillC.toString(),icon: Icons.airline_stops_outlined),
              SizedBox(width: 8,),
              _cardBox(title: "DewPoint",data:  data, semiTitle:  "${data.current!.dewpointC}°",icon: Icons.ac_unit),
              SizedBox(width: 8,),
              _cardBox(title: "Heat Index",data:  data,semiTitle:  "${data.current!.heatindexC}°",icon:  Icons.heat_pump_outlined),
              SizedBox(width: 8,),
              _cardBox(title:  "Wind Speed",data:  data,semiTitle:  data.current!.windKph.toString(),icon:  Icons.wind_power),
              SizedBox(width: 8,),
              _cardBox(title:  "Pressure",data:  data,semiTitle:  data.current!.pressureIn.toString() ,icon:  Icons.compress),
              SizedBox(width: 8,),
              _cardBox(title:  "Humidity",data:  data,semiTitle:  data.current!.humidity.toString(),icon:  Icons.hub),
            ],
          ),
        ),
        SizedBox(height: 8,),
        Text(" Additional Information",style: TextStyle(
            fontSize: 30
        ),),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _AdditionalIcon(icon: Icons.water_drop_outlined,title: "Humidity",number: data.current!.humidity.toString(),),
            _AdditionalIcon(icon: Icons.speed_rounded,title: "Wind Speed",number: data.current!.windMph.toString(),),
            _AdditionalIcon(icon: Icons.open_with_sharp,title: "Pressure",number: data.current!.pressureIn.toString(),),
          ],
        )
      ],
    );
  }
}

class _cardBox extends StatelessWidget {
  final String title;
  final WeatherData data;
  final String semiTitle;
  final IconData icon;
  const _cardBox({ required this.title, required this.data, required this.semiTitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(title,style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
              // Image.network("https:${data.current?.condition?.icon}",height: 50,width: 50,fit: BoxFit.cover,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(icon,size: 40),
              ),
              Text(semiTitle)
            ],
          ),
        ),
      ),
    );
  }
}



class _AdditionalIcon extends StatelessWidget {
  final String title;
  final String number;
  final IconData icon;
  const _AdditionalIcon({ required this.icon, required this.title, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(icon,size: 50,),
        ),
        Text(title,style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),),
        Text(number,style: TextStyle(
          fontWeight: FontWeight.bold,
        )),
      ],
    );
  }
}