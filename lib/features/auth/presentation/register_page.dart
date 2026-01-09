import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

   @override
  State<Register> createState() => _RegisterState();

  }

  class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;


  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      _showMessage('Password dan konfirmasi tidak sama');
      return;
    }

     try {
      setState(() => _isLoading = true);

      final result = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

    // Simpan display name
      await result.user!.updateDisplayName(
        _nameController.text.trim(),
      );

      _showMessage('Registrasi berhasil');

    Navigator.pop(context); // kembali ke login
    } on FirebaseAuthException catch (e) {
      _showMessage(e.message ?? 'Registrasi gagal');
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
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.person_add_alt,
                  size: 70,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),

                const Text(
                  "Buat Akun Baru",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),
                const Text(
                  'Silakan daftar untuk melanjutkan',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // Nama
                 TextField(
                  controller: _nameController,
                  decoration: _inputDecoration(
                    'Nama Lengkap',
                    'Masukkan nama Anda',
                    Icons.person_outline,
                  ),
                ),

                const SizedBox(height: 20),

                // Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDecoration(
                    'Email',
                    'Masukkan email Anda',
                    Icons.email_outlined,
                  ),
                ),

                const SizedBox(height: 20),

                // Password
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _inputDecoration(
                    'Password',
                    'Masukkan password',
                    Icons.lock_outline,
                  ),
                ),

                const SizedBox(height: 20),

                // Konfirmasi Password
                      TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: _inputDecoration(
                    'Konfirmasi Password',
                    'Ulangi password Anda',
                    Icons.lock_outline,
                  ),
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed:  _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading ?
                      const CircularProgressIndicator(color: Colors.white,
                      strokeWidth: 2,):
                      const Text(
                    'Daftar',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Sudah punya akun? "),
                    GestureDetector(
                      onTap: ()  => Navigator.pop(context), // kembali ke Login
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    String hint,
    IconData icon,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
