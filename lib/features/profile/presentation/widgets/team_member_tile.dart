import 'package:flutter/material.dart';

class TeamMemberTile extends StatelessWidget {
  final String name;
  final String nim;
  final String role;
  final Color backgroundColor;
  final Color accentColor;
  final VoidCallback onTap;

  const TeamMemberTile({
    super.key,
    required this.name,
    required this.nim,
    required this.role,
    required this.backgroundColor,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor.withOpacity(0.9),
            backgroundColor.withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: accentColor.withOpacity(0.2),
          child: Icon(Icons.person, color: accentColor),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              nim,
              style: const TextStyle(fontSize: 13),
            ),
            Text(
              role,
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: accentColor,
              ),
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: accentColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
