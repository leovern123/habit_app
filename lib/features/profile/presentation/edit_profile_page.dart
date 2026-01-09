import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import '../data/profile_service.dart';
import '../data/supabase_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Uint8List? _webImage;
  File? _selectedImage;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;


    Widget _buildAvatar(User? user) {
    if (kIsWeb && _webImage != null) {
      return Image.memory(_webImage!, fit: BoxFit.cover);
    }

    if (!kIsWeb && _selectedImage != null) {
      return Image.file(_selectedImage!, fit: BoxFit.cover);
    }

    if (user?.photoURL != null) {
      return Image.network(user!.photoURL!, fit: BoxFit.cover);
    }

    return const Icon(Icons.person, size: 60, color: Colors.grey);
  }

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
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        setState(() {
          _webImage = bytes;
        });
      } else {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
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

      if (_selectedImage != null || _webImage != null) {
        photoUrl = await _storageService.uploadAvatar(
          userId: user.uid,
          imageFile: _selectedImage,
          webBytes: _webImage,
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

    final isGoogleUser = user?.providerData.any(
          (info) => info.providerId == 'google.com',
        ) ??
        false;

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
                    child: _buildAvatar(user),
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
                    Text(
                      'Ubah Password (Opsional)',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isGoogleUser ? Colors.grey : Colors.black,
                      ),
                    ),
                    if (isGoogleUser)
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'Akun Google tidak dapat mengubah password.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _passwordController,
                      label: 'Password Baru',
                      icon: Icons.lock_outline,
                      obscure: _obscurePassword,
                      enabled: !isGoogleUser,
                      onToggleObscure: isGoogleUser
                          ? null
                          : () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                    ),
                    const SizedBox(height: 12),
                    _buildField(
                      controller: _confirmPasswordController,
                      label: 'Konfirmasi Password',
                      icon: Icons.lock_reset,
                      obscure: _obscureConfirmPassword,
                      enabled: !isGoogleUser,
                      onToggleObscure: isGoogleUser
                          ? null
                          : () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
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
    VoidCallback? onToggleObscure,
  }) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscure,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: onToggleObscure != null
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: onToggleObscure,
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}