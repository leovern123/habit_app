import 'package:flutter/material.dart';
import 'package:uas_flutter/features/auth/presentation/login_page.dart';
import 'package:uas_flutter/features/profile/presentation/edit_profile_page.dart';
import '../data/profile_service.dart';
import 'about_team_page.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_menu_item.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfileService _service = ProfileService();

  @override
  Widget build(BuildContext context) {
    final user = _service.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        centerTitle: true,
        backgroundColor: Colors.green.shade100, 
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ProfileHeader(
              name: user?.displayName ?? 'User',
              email: user?.email ?? '-',
              photoUrl: user?.photoURL,
            ),
            const SizedBox(height: 24),
            ProfileMenuItem(
              icon: Icons.edit,
              title: 'Edit Profil',
              subtitle: 'Ubah foto dan nama',
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const EditProfilePage(),
                  ),
                );

                if (result == true) {
                  setState(() {}); 
                }
              },
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
                await ProfileService().logout();

                if (!context.mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const Login()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

