import 'package:flutter/material.dart';
import '../data/profile_service.dart';
import 'about_team_page.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = ProfileService();
    final user = service.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF4FAFF),
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileHeader(
              name: user?.displayName ?? 'User',
              email: user?.email ?? '-',
            ),
            const SizedBox(height: 24),
            ProfileMenuItem(
              icon: Icons.edit,
              title: 'Edit Profil',
              subtitle: 'Ubah foto dan nama',
              onTap: () {},
            ),
            ProfileMenuItem(
              icon: Icons.info_outline,
              title: 'Tentang Kami',
              subtitle: 'Informasi pengembang aplikasi',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AboutTeamPage(),
                  ),
                );
              },
            ),
            ProfileMenuItem(
              icon: Icons.logout,
              title: 'Keluar',
              subtitle: 'Logout dari akun',
              isDanger: true,
              onTap: () async {
                await service.logout();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
