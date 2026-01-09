import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uas_flutter/features/splash/presentation/splash_screen_3.dart';

class MySplashScreen2 extends StatefulWidget {
  const MySplashScreen2({super.key});

  @override
  State<MySplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<MySplashScreen2> {
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MySplashScreen3()),
      );
    });
  }

 @override
 Widget build(BuildContext context) {
 return Scaffold( 
      body: Center(
        child: Column(
          children: [
            const Spacer(flex: 1),
            
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

              const SizedBox(height: 50),
                
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 13,
                    height: 13,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFedede9), 
                    ),
                  ),
                  Container(
                    width: 13,
                    height: 13,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF84a98c), //aktif
                    ),
                  ),
                  Container(
                    width: 13,
                    height: 13,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFedede9),
                    ),
                  ),
                  Container(
                    width: 13,
                    height: 13,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFedede9),
                    ),
                  ),
                  Container(
                    width: 13,
                    height: 13,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFedede9),
                    ),
                  ),
                ],
              ),  

               const SizedBox(height: 30),

              Lottie.asset(
              'assets/lotties/Sandy Loading.json',
              width: 50,
              height: 50,
              repeat: true,
            ),
            const Spacer(flex: 1),
          ]
        ),
      ),
  );
  }
  }