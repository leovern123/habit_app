import 'package:flutter/material.dart';

class SplashScreen1 extends StatelessWidget {
  const SplashScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            // Gambar bulat di tengah dengan logo global
            Container(
              width: 230,
              height: 230,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
                image: DecorationImage(
                  image: AssetImage("assets/images/logo_global.jpg"),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),

            const SizedBox(height: 30), 

             const Text(
              "Welcome to Habit App",
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            const Text(
                "Mulai kebiasaan baikmu dan capai tujuanmu dengan aplikasi Habit App!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 50),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 0, 148, 62), // aktif
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 185, 246, 202), // non-aktif
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 12,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 185, 246, 202), // non-aktif
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),

              Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                      
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 1, 165, 37),
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
          ]
        )
      )
    );
  }
}
