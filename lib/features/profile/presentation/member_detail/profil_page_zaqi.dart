import 'package:flutter/material.dart';

class MemberPageZaqi extends StatelessWidget {
  const MemberPageZaqi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        centerTitle: true,
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
              backgroundImage: AssetImage('assets/images/zaqi.jpeg'),
            ),
            const SizedBox(height: 16),
            const Text(
              'Zaqi Maulana',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'TI-23-SE-SH',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _item(Icons.badge, 'NIM', '1123150048'),
            _item(Icons.email, 'Email', 'zaqimaulana72@email.com'),
            _item(Icons.code, 'Keahlian', 'Flutter & Firebase'),
          ],
        ),
      ),
    );
  }

  Widget _item(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
