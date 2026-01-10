import 'package:flutter/material.dart';

class MemberFarasPage extends StatelessWidget {
  const MemberFarasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0D47A1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            Transform.translate(
              offset: const Offset(0, -60),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/images/faras.jpeg'),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Rayhan Faras',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            const Text(
              'TI-23-SE-M',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            _item(Icons.badge, 'NIM', '1123150010'),
            _item(Icons.email, 'Email', 'rayhanfaras@email.com'),
            _item(Icons.developer_mode, 'Keahlian', 'Flutter UI, REST API'),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  static Widget _item(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
