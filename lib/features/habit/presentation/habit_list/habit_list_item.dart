import 'package:flutter/material.dart';


class HabitListItem extends StatelessWidget {
  final String title;
  final bool isActive;

  final bool notificationOn;
  final VoidCallback onToggleNotification;

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  

  const HabitListItem({
    super.key,
    required this.title,
    required this.isActive,
    required this.notificationOn,
    required this.onToggleNotification,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
    leading: Icon(
      isActive ? Icons.check_circle : Icons.remove_circle_outline,
      color: isActive ? Colors.green.shade600 : Colors.grey,
    ),

    title: Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: isActive ? Colors.black : Colors.grey,
      ),
    ),

    subtitle: Text(
      isActive ? 'Aktif' : 'Nonaktif',
      style: TextStyle(
        fontSize: 12,
        color: isActive ? Colors.green.shade600 : Colors.grey,
      ),
    ),
            
           trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ICON NOTIFIKASI
            IconButton(
              icon: Icon(
                notificationOn
                    ? Icons.notifications_active
                    : Icons.notifications_off,
                color: notificationOn
                    ? Colors.green.shade600
                    : Colors.grey,
              ),
              tooltip:
                  notificationOn ? 'Notifikasi aktif' : 'Notifikasi mati',
              onPressed: onToggleNotification,
            ),


            // POPUP MENU 
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onEdit();
                if (value == 'toggle') onToggleActive();
                if (value == 'delete') onDelete();
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(
                    value: 'toggle', child: Text('Aktif / Nonaktif')),
                PopupMenuItem(value: 'delete', child: Text('Hapus')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}