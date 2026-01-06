import 'package:flutter/material.dart';

class TeamMemberTile extends StatelessWidget {
  const TeamMemberTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: const Text(
          'Zaqi',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        subtitle: const Text('Mobile Developer'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}