import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MySplashScreen4 extends StatefulWidget {
  const MySplashScreen4({super.key});

  @override
  State<MySplashScreen4> createState() => _MySplashScreen4State();
}

class _MySplashScreen4State extends State<MySplashScreen4> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MySplashScreen4(),
        ),
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
              "assets/lotties/graph.json",
              width: 220,
              height: 220,
            ),

            const SizedBox(height: 30),

            const Text(
              "Build Positive Habits",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F3E46),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Pantau perkembanganmu dan\ncapai target setiap hari",
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
                _dot(false),
                _dot(false),
                _dot(true),
                _dot(false),
                _dot(false),
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

  static Widget _dot(bool active) {
    return Container(
      width: 13,
      height: 13,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: active ? const Color(0xFF84a98c) : const Color(0xFFedede9),
      ),
    );
  }
}
