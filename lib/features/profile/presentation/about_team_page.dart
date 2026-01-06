import 'package:flutter/material.dart';
import 'widgets/team_member_tile.dart';
import 'member_detail/profil_page_zaqi.dart';

class AboutTeamPage extends StatelessWidget {
  const AboutTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Team')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TeamMemberTile(
            name: 'Zaqi',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MemberPage()),
            ),
          ),
        ],
      ),
    );
  }
}