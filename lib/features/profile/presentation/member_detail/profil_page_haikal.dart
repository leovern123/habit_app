import 'package:flutter/material.dart';

class MemberHaikalPage extends StatelessWidget {
  const MemberHaikalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB39DDB),
                  Color(0xFF81D4FA),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage:
                        AssetImage('assets/images/haikal.jpeg'),
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    'Haikal Falah',
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
                      color: Colors.white70,
                    ),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: const [
                        GlassProfileItem(
                          icon: Icons.badge,
                          label: 'NIM',
                          value: '5566778899',
                        ),
                        Divider(color: Colors.white30),
                        GlassProfileItem(
                          icon: Icons.email,
                          label: 'Email',
                          value: 'haikal@email.com',
                        ),
                        Divider(color: Colors.white30),
                        GlassProfileItem(
                          icon: Icons.star,
                          label: 'Keahlian',
                          value: 'Heker dan Cyber scurity',
                        ),
                        Divider(color: Colors.white30),
                        GlassProfileItem(
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
          ),
        ],
      ),
    );
  }
}

class GlassProfileItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const GlassProfileItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.white70,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
