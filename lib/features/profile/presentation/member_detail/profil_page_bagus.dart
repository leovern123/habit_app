import 'package:flutter/material.dart';

class MemberBagusPage extends StatelessWidget {
  const MemberBagusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage:
                        AssetImage('assets/images/bagus.jpeg'),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Bagus Ferdiansyah',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'TI-23-SE-M • Teknik Informatika',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            const SectionTitle(title: 'Biodata'),
            const ProfileLine(
              icon: Icons.badge_outlined,
              label: 'NIM',
              value: '6677889900',
            ),
            const ProfileLine(
              icon: Icons.email_outlined,
              label: 'Email',
              value: 'bagus@email.com',
            ),

            const SizedBox(height: 20),

            const SectionTitle(title: 'Keahlian'),
            const ProfileLine(
              icon: Icons.check_circle_outline,
              label: 'Skill',
              value: 'Flutter UI, API Integration',
            ),
            const ProfileLine(
              icon: Icons.check_circle_outline,
              label: 'Tools',
              value: 'VS Code, Firebase',
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ProfileLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileLine({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$label : $value',
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
