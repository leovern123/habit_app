import 'package:flutter/material.dart';

class MemberFarasPage extends StatelessWidget {
  const MemberFarasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Container(
            height: 220,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                'Profil Mahasiswa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -60),
            child: const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 52,
                backgroundImage:
                    AssetImage('assets/images/faras.jpeg'),
              ),
            ),
          ),

          const SizedBox(height: -40),

          const Text(
            'Rayhan Faras',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'TI-23-SE-M',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              child: Column(
                children: const [
                  ProfileRow(
                    icon: Icons.badge_outlined,
                    title: 'NIM',
                    value: '1123150010',
                  ),
                  Divider(),
                  ProfileRow(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    value: 'rayhanfaras@email.com',
                  ),
                  Divider(),
                  ProfileRow(
                    icon: Icons.developer_mode_outlined,
                    title: 'Keahlian',
                    value: 'Flutter UI, REST API',
                  ),
                  Divider(),
                  ProfileRow(
                    icon: Icons.school_outlined,
                    title: 'Program Studi',
                    value: 'Teknik Informatika',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


