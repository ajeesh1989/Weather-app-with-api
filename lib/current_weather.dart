import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/api/api.dart';
import 'package:weather_app/model/weather.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({super.key});

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

final ValueNotifier<double> temperature = ValueNotifier<double>(0.0);

class _CurrentWeatherState extends State<CurrentWeather> {
  final _cityController = TextEditingController();
  Future<Weather?>? futureWeather;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   elevation: 0,
        //   backgroundColor: Colors.blue,
        //   centerTitle: true,
        //   title: const Text(
        //     'Weather',
        //     style: TextStyle(
        //         color: Colors.white, fontSize: 30, fontWeight: FontWeight.w100),
        //   ),
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.bottomLeft,
        //           end: Alignment.topRight,
        //           colors: <Color>[
        //             Colors.blue,
        //             Color.fromARGB(255, 24, 20, 20),
        //           ]),
        //     ),
        //   ),
        // ),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 43, 35, 109),
                Color.fromARGB(255, 24, 20, 20),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  controller: _cityController,
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 0.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blueGrey, width: 0.0),
                    ),
                    hintText: 'Search a city..',
                    hintStyle: const TextStyle(color: Colors.grey),
                    suffixIcon: IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();

                        final city = _cityController.text;

                        setState(() {
                          futureWeather = fetchWeather(city: city);
                        });
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  // onChanged: (value) {
                  //   FocusManager.instance.primaryFocus?.unfocus();

                  //   final city = _cityController.text;

                  //   setState(() {
                  //     futureWeather = fetchWeather(city: city);
                  //   });
                  // },
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder<Weather?>(
                  future: futureWeather,
                  builder: (context, snapshot) {
                    log(futureWeather.toString());
                    if (snapshot.hasData) {
                      final result = snapshot.data;

                      double tempDouble = double.parse(result!.tempC ?? "0.0");

                      temperature.value = tempDouble;

                      log(result.toString());
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${result.name}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w200),
                              ),
                              Text(
                                '${result.tempC}°C',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 50,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                          ValueListenableBuilder(
                            valueListenable: temperature,
                            builder: (context, double value, _) {
                              log('temp: ${temperature.value}');
                              return getImage(temperature.value);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Current weather condition - ${result.condition}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Today - ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300)),
                          const SizedBox(
                            height: 30,
                          ),
                          //image

                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Text('Country',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${result.country}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('Temp - F',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${result.tempF}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text('Humidity',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${result.humidity}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error : ${snapshot.error}');
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 250),
                        child: Column(
                          children: const [
                            Center(
                              child: Text(
                                'No data available',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200),
                              ),
                            ),
                            // Center(
                            //   child: Lottie.network(
                            //     'https://assets2.lottiefiles.com/packages/lf20_rc6CDU.json',
                            //     width: 250,
                            //     height: 250,
                            //     fit: BoxFit.fill,
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 200),
                        child: CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 230),
                        child: Text(
                          "Something went wrong!!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getImage(double temperature) {
    if (temperature < 10) {
      return Lottie.network(
          'https://assets4.lottiefiles.com/private_files/lf30_0tyvusxj.json',
          fit: BoxFit.cover);
    } else if (temperature <= 20) {
      return Lottie.network(
          'https://assets4.lottiefiles.com/packages/lf20_trr3kzyu.json');
    } else if (temperature <= 30) {
      return Lottie.network(
          'https://assets2.lottiefiles.com/temp/lf20_dgjK9i.json');
    } else if (temperature <= 40) {
      return Lottie.network(
          'https://assets1.lottiefiles.com/packages/lf20_xlky4kvh.json');
    } else {
      return Lottie.network(
          'https://assets1.lottiefiles.com/packages/lf20_xlky4kvh.json');
    }
  }
}
