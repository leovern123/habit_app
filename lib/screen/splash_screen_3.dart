import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen3 extends StatelessWidget {
  const SplashScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),

            Lottie.asset(
              "assets/lotties/succes.json",
              width: 220,
              height: 220,
            ),
          ],
        ),        
      ),
    );
  }
}