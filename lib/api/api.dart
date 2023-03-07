import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:weather_app/model/weather.dart';

Future<Weather?> fetchWeather({required String city}) async {
  Weather data;
  const apiKey = '32316bd99abd4b1f83950732230703';
  final url =
      'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$city&aqi=no';

  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // here convert object to json string
    final bodyAsJson = jsonDecode(response.body) as Map<String, dynamic>;
    log(response.body);

    data = Weather.fromJson(bodyAsJson);

    return data;
  } else {
    throw Exception('Failed to fetch weather data');
  }
}
