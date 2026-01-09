import 'package:flutter/material.dart';

class MemberPageUmar extends StatelessWidget {
  const MemberPageUmar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Profil Umar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.6),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('assets/images/umar.jpeg'),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Umar Bakri',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'TI-23-SE-SH',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            Card(
              color: const Color(0xFF1E1E1E),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 6,
              child: Column(
                children: const [
                  UmarProfileItem(
                    icon: Icons.badge,
                    label: 'NIM',
                    value: '1123150046',
                  ),
                  Divider(color: Colors.grey),
                  UmarProfileItem(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'umar@email.com',
                  ),
                  Divider(color: Colors.grey),
                  UmarProfileItem(
                    icon: Icons.memory,
                    label: 'Keahlian',
                    value: 'Flutter Logic, Firebase Auth',
                  ),
                  Divider(color: Colors.grey),
                  UmarProfileItem(
                    icon: Icons.school,
                    label: 'Program Studi',
                    value: 'Teknik Informatika',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
