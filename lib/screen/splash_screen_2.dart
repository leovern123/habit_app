import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class MySplashScreen2 extends StatelessWidget {
 const MySplashScreen2({super.key});

 @override
 Widget build(BuildContext context) {
 return Scaffold( 
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            
            Lottie.asset(
              "assets/lotties/calendar.json",
              width: 220,
              height: 220,
            ),
          ]
        ),
      ),
  );
  }
  }