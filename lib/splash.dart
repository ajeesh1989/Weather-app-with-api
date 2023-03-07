import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'current_weather.dart';

class MySplash extends StatefulWidget {
  const MySplash({super.key});

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    startTime();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
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
            child: Center(
              // child: Text(
              //   'Weather Hub',
              //   style: TextStyle(fontSize: 40, color: Colors.white70),
              // ),
              child: AnimatedTextKit(
                animatedTexts: [
                  FadeAnimatedText(
                    duration: Duration(seconds: 3),
                    'Weather Hub',
                    textStyle:
                        const TextStyle(fontSize: 40.0, color: Colors.white),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Timer> startTime() async {
    var duration = new Duration(seconds: 4);
    return Timer(
      duration,
      route,
    );
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => CurrentWeather()));
  }
}
