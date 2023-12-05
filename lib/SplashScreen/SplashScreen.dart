import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loginsit/HomePage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change to your desired background color
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Lottie animation
          Positioned.fill(
            child: Lottie.asset(
              'assets/lottie/DB.json',
              fit: BoxFit.fitWidth,
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..forward();
              },
            ),
          ),
          // Loading symbol at the bottom center
          Positioned(
            bottom: 140, // Adjust the value to position it as needed
            left: 0,
            right: 0,
            child: Center(
              child:
                  CircularProgressIndicator(), // You can use any loading widget here
            ),
          ),
        ],
      ),
    );
  }
}
