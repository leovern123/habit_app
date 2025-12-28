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
            const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            const Text(
              "Welcome to Habit App",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              "Mulai kebiasaan baikmu dan capai tujuanmu dengan aplikasi Habit App!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dot(false),
                _dot(false),
                _dot(false),
                _dot(true),
                _dot(false),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // aksi nanti
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 1, 165, 37),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _dot(bool isActive) {
  return Container(
    width: 12,
    height: 12,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: isActive
          ? const Color.fromARGB(255, 0, 148, 62)
          : const Color.fromARGB(255, 185, 246, 202),
    ),
  );
}
