import 'package:flutter/material.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

   final List<Widget> _pages = const [
    _PlaceholderPage(title: 'Dashboard'),
    _PlaceholderPage(title: 'Habit List'),
    _PlaceholderPage(title: 'Statistik'),
    _PlaceholderPage(title: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      