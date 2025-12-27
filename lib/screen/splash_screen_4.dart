import 'package:flutter/material.dart';

class SplashScreen4 extends StatelessWidget {
  const SplashScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Splash Screen 4",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 50),
            Container(
              width: 230,
              height: 230,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage("assets/images/logo_global.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
