import 'package:flutter/material.dart';

class AboutTeamPage extends StatelessWidget {
  const AboutTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Team'),
      ),
      body: const Center(
        child: Text('About Team Page Content Here'),
      ),
    );
  }
}