import 'package:flutter/material.dart';
import '../../model/habit_model.dart';


class HabitListItem extends StatelessWidget {
  final String habitId;
  final String title;
  final bool isActive;
  final bool notificationOn;
  final DateTime habitTime;

  final VoidCallback onToggleNotification;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleActive;

  const HabitListItem({
    super.key,
    required this.habitId,
    required this.title,
    required this.isActive,
    required this.notificationOn,
    required this.habitTime,
    required this.onToggleNotification,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleActive,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
        subtitle: Row(
          children: [
            Text(
              isActive ? 'Aktif' : 'Nonaktif',
              style: TextStyle(
                fontSize: 12,
                color: isActive ? Colors.green.shade600 : Colors.grey,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              notificationOn ? 'Notif ON' : 'Notif OFF',
              style: TextStyle(
                fontSize: 12,
                color: notificationOn ? Colors.green.shade600 : Colors.grey,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                notificationOn ? Icons.notifications_active : Icons.notifications_off,
                color: notificationOn ? Colors.green.shade600 : Colors.grey,
              ),
              tooltip: notificationOn ? 'Notifikasi aktif' : 'Notifikasi mati',
              onPressed: onToggleNotification,
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') onEdit();
                if (value == 'toggle') onToggleActive();
                if (value == 'delete') onDelete();
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit', child: Text('Edit')),
                PopupMenuItem(value: 'toggle', child: Text('Aktif / Nonaktif')),
                PopupMenuItem(value: 'delete', child: Text('Hapus')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
