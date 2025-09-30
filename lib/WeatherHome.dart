import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/ElevatedBox.dart';
import 'package:weather_flutter/WeatherViewModel.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }
  void _sendCityName(){
    if(_controller.text.isNotEmpty){
      final viewModel = context.read<WeatherViewModel>();
      viewModel.getAllData(_controller.text.trim());
      _controller.clear();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter the city name")));
    }
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<WeatherViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        centerTitle: true,
      ),
      body: SafeArea(child:
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: (city){
                      if(city.isNotEmpty){
                        viewModel.getAllData(city);
                        _controller.clear();
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter the city name")));
                      }
                    },
                    decoration: InputDecoration(
                      hint: Text("Enter the city",style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 3.5,
                        ),
                        borderRadius: BorderRadius.circular(16)
                      ),
                    ),

                  ),
                ),
              SizedBox(width: 8,),
                SizedBox(
                  height: 55,
                  child: OutlinedButton(onPressed: (){
                    _sendCityName();
                  },
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))
                    ),
                              child: Text("Search",style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),),),
                )
              ],
            ),
            SizedBox(height: 8,),
            Consumer<WeatherViewModel>(builder: (context,viewModel,_){
              if(viewModel.loading){
                 return const CircularProgressIndicator();
              }else if(viewModel.error.isNotEmpty){
                return  Text(viewModel.error);
              }else if(viewModel.weatherData.location!=null){
                return ElevatedBox(data:  viewModel.weatherData);
              }else{
                return Text("Enter city name");
              }
            })
          ],
        ),
      )),
    );
  }
}







