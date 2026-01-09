import 'package:flutter/material.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Detail'),
      ),
      body: const Center(
        child: Text('Member Detail Page Content Here'),
      ),
    );
  }
}