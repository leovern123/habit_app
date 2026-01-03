import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uas_flutter/screen/splash_screen_5.dart';


class MySplashScreen4 extends StatefulWidget {
  const MySplashScreen4({super.key}); 


  @override
  State<MySplashScreen4> createState() => _SplashScreen4State();
}

class _SplashScreen4State extends State<MySplashScreen4> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashScreen5()),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),

            Lottie.asset(
              "assets/lotties/income_tracker_final.json",
              width: 220,
              height: 220,
            ),

            const SizedBox(height: 30), 

             const Text(
              "Make Good Habits Stick",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3E46),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
                "Atur target, catat perkembangan, dan \n tetap konsisten setiap hari.",
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
                      color: Color(0xFF84a98c), // aktif
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
          ],
        ),        
      ),
    );
  }
}