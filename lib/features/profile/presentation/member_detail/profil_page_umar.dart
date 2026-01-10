import 'package:flutter/material.dart';

class MemberPageUmar extends StatelessWidget {
  const MemberPageUmar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F9),
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        backgroundColor: const Color(0xFF009688),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
                ),
              ),
              child: const CircleAvatar(
                radius: 58,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/umar.jpeg'),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Umar Bakri',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'TI-23-SE-SH • Teknik Informatika',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Column(
                children: const [
                  UmarItem(
                    icon: Icons.badge_outlined,
                    label: 'NIM',
                    value: '1123150046',
                  ),
                  Divider(height: 0),
                  UmarItem(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: 'umar@email.com',
                  ),
                  Divider(height: 0),
                  UmarItem(
                    icon: Icons.memory_outlined,
                    label: 'Keahlian',
                    value: 'Flutter Logic, Firebase Auth',
                  ),
                  Divider(height: 0),
                  UmarItem(
                    icon: Icons.school_outlined,
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

class UmarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const UmarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF009688)),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black54,
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}
