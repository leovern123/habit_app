import 'package:flutter/material.dart';
import 'package:uas_flutter/features/profile/presentation/member_detail/profil_page_bagus.dart';
import 'package:uas_flutter/features/profile/presentation/member_detail/profil_page_haikal.dart';
import 'package:uas_flutter/features/profile/presentation/member_detail/profil_page_umar.dart';
import 'widgets/team_member_tile.dart';
import 'member_detail/profil_page_zaqi.dart';
import 'member_detail/profil_page_faras.dart';

class AboutTeamPage extends StatelessWidget {
  const AboutTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Team'),
        backgroundColor: Colors.green.shade700,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TeamMemberTile(
            name: 'Zaqi',
            nim: '1123150048',
            role: 'Flutter Developer',
            backgroundColor: Colors.green.shade100,
            accentColor: Colors.green.shade800,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberPageZaqi()),
            ),
          ),
          TeamMemberTile(
            name: 'Umar',
            nim: '1123150046',
            role: 'Project Manager',
            backgroundColor: Colors.lightGreen.shade100,
            accentColor: Colors.lightGreen.shade800,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberPageUmar()),
            ),
          ),
          TeamMemberTile(
            name: 'Haikal',
            nim: '1123150041',
            role: 'Flutter Developer',
            backgroundColor: Colors.green.shade100,
            accentColor: Colors.green.shade800,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberHaikalPage()),
            ),
          ),
          TeamMemberTile(
            name: 'Bagus',
            nim: '1123150038',
            role: 'UI/UX Designer',
            backgroundColor: Colors.lightGreen.shade100,
            accentColor: Colors.lightGreen.shade800,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberBagusPage()),
            ),
          ),
          TeamMemberTile(
            name: 'Faras',
            nim: '1123150010',
            role: 'Frontend Developer',
            backgroundColor: Colors.green.shade100,
            accentColor: Colors.green.shade800,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberFarasPage()),
            ),
          ),
        ],
      ),
    );
  }
}
