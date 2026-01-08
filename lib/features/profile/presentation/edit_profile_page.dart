import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../data/profile_service.dart';
import '../data/supabase_storage_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _profileService = ProfileService();
  final _storageService = SupabaseStorageService();

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  File? _selectedImage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = _profileService.currentUser;
    _nameController.text = user?.displayName ?? '';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _saveProfile() async {
    final user = _profileService.currentUser;
    if (user == null) return;

    if (_passwordController.text.isNotEmpty &&
        _passwordController.text != _confirmPasswordController.text) {
      _showMessage('Konfirmasi password tidak cocok');
      return;
    }

    setState(() => _isLoading = true);

    try {
      String? photoUrl;

      if (_selectedImage != null) {
        photoUrl = await _storageService.uploadAvatar(
          imageFile: _selectedImage!,
          userId: user.uid,
        );
      }

      await _profileService.updateProfile(
        displayName: _nameController.text.trim(),
        photoUrl: photoUrl,
        newPassword: _passwordController.text.isEmpty
            ? null
            : _passwordController.text,
      );

      if (mounted) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      _showMessage('Gagal menyimpan profil');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _profileService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF4FAFF), Color(0xFFE6F0FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.grey.shade200,
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : (user?.photoURL != null
                            ? Image.network(
                                user!.photoURL!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.person,
                                size: 60,
                                color: Colors.grey,
                              )),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField(
                      controller: _nameController,
                      label: 'Nama Lengkap',
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 16),
                    _buildField(
                      initialValue: user?.email ?? '',
                      label: 'Email',
                      icon: Icons.email_outlined,
                      enabled: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ubah Password (Opsional)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _passwordController,
                      label: 'Password Baru',
                      icon: Icons.lock_outline,
                      obscure: true,
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _confirmPasswordController,
                      label: 'Konfirmasi Password',
                      icon: Icons.lock_reset,
                      obscure: true,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildField({
    TextEditingController? controller,
    String? initialValue,
    required String label,
    required IconData icon,
    bool obscure = false,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscure,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
