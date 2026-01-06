import 'package:flutter/material.dart';
import '../../auth/data/auth_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _photoController = TextEditingController();
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    final user = _authService.currentUser;
    _nameController.text = user?.displayName ?? '';
    _photoController.text = user?.photoURL ?? '';
  }

  Future<void> _saveProfile() async {
    await _authService.updateProfile(
      name: _nameController.text.trim(),
      photoUrl: _photoController.text.trim(),
    );

    if (mounted) {
      Navigator.pop(context, true); // kembali + refresh
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _photoController,
              decoration: const InputDecoration(
                labelText: 'URL Foto Profil',
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
