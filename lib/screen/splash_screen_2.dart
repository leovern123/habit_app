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

            const SizedBox(height: 30), 

             const Text(
              "Track Your Daily Routine",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3E46),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
                "Buat jadwal harian\n dan atur rutinitas mu dengan mudah",
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 15,
                color: Color(0xFF52796F),
                height: 1.5,
                ),
              ),
          ]
        ),
      ),
  );
  }
  }