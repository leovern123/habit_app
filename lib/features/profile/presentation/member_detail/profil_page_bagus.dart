import 'package:flutter/material.dart';

class MemberBagusPage extends StatelessWidget {
  const MemberBagusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/bagus.jpeg'),
            ),
            const SizedBox(height: 14),
            const Text(
              'Bagus Ferdiansyah',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'TI-23-SE-M • Teknik Informatika',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _infoCard(
              Icons.badge,
              'NIM',
              '1123150038',
            ),
            _infoCard(
              Icons.email,
              'Email',
              'bagus@email.com',
            ),
            _infoCard(
              Icons.code,
              'Keahlian',
              'Flutter UI, API Integration',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
