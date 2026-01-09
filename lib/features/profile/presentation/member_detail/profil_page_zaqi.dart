import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profil Member'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/zaqi.jpeg'),
            ),

            const SizedBox(height: 16),

            const Text(
              'Zaqi Maulana',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              'TI-23-SE-SH',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),

            const SizedBox(height: 20),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    ProfileItem(
                      icon: Icons.badge,
                      label: 'NIM',
                      value: '1123150048',
                    ),
                    Divider(),
                    ProfileItem(
                      icon: Icons.email,
                      label: 'Email',
                      value: 'zaqimaulana72@email.com',
                    ),
                    Divider(),
                    ProfileItem(
                      icon: Icons.code,
                      label: 'Keahlian',
                      value: 'Flutter Basic, Firebase',
                    ),
                    Divider(),
                    ProfileItem(
                      icon: Icons.school,
                      label: 'Program Studi',
                      value: 'Teknik Informatika',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// WIDGET ITEM PROFIL
class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

