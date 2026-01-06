import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class HabitListPage extends StatelessWidget {
  const HabitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit List'),
      ),
      body: userId == null
          ? const Center(child: Text('User belum login'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('habits')
                  .where('userId', isEqualTo: userId)
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {

                  return const HabitListEmpty();
                }

                final habits = snapshot.data!.docs;


                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: habits.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final doc = habits[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return HabitListItem(
                      title: data['title'] ?? '-',
                      isActive: data['isActive'] ?? true,
                      onToggleActive: () async {
                      await doc.reference.update({
                          'isActive': !(data['isActive'] ?? true),
                        });
                      },
                      onDelete: () async {
                       await doc.reference.delete();
                      },
                      onEdit: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Edit habit segera tersedia'),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
    );
  }
}
