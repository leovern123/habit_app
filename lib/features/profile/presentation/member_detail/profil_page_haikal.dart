import 'package:flutter/material.dart';

class MemberHaikalPage extends StatelessWidget {
  const MemberHaikalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7E57C2), Color(0xFF64B5F6)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 20),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage('assets/images/haikal.jpeg'),
              ),
              const SizedBox(height: 14),
              const Text(
                'Haikal Falah',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const Text(
                'TI-23-SE-SH',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 24),
              _glassItem(Icons.badge, 'NIM', '1123150041'),
              _glassItem(Icons.email, 'Email', 'haikal@email.com'),
              _glassItem(Icons.security, 'Keahlian', 'Cyber Security'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassItem(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white70)),
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }
}
