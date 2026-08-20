import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home/home_screen.dart';
import 'map/map_screen.dart';
import 'chat/chat_screen.dart';
import 'hub/hub_screen.dart';
import 'history/history_screen.dart';
import 'profile/profile_screen.dart';
import 'post_task/post_task_screen.dart';

/// The main app shell. Bottom nav follows the PRD's list — Map, Chat,
/// Vasatyl Hub, Post Task, History, Me — with Post Task surfaced as a
/// prominent center action, matching the sketch's layout.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  final _screens = const [
    HomeScreen(),
    MapScreen(),
    ChatScreen(),
    HubScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  void _openPostTask() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PostTaskScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      floatingActionButton: FloatingActionButton(
        onPressed: _openPostTask,
        backgroundColor: AppColors.primaryGreen,
        shape: const CircleBorder(),
        elevation: 3,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(icon: Icons.location_on_outlined, label: 'Map', idx: 1),
              _navItem(icon: Icons.chat_bubble_outline, label: 'Chat', idx: 2),
              _navItem(icon: Icons.public, label: 'Hub', idx: 3),
              const SizedBox(width: 40), // notch space for FAB
              _navItem(icon: Icons.history, label: 'History', idx: 4),
              _navItem(icon: Icons.person_outline, label: 'Me', idx: 5),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem({required IconData icon, required String label, required int idx}) {
    final selected = _index == idx;
    final color = selected ? AppColors.primaryGreen : AppColors.textMuted;
    return InkWell(
      onTap: () => setState(() => _index = idx),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

/// Lets any screen (e.g. Home) jump straight to a bottom-nav tab like History.
class TabNavigator extends InheritedWidget {
  final void Function(int index) goToTab;

  const TabNavigator({super.key, required this.goToTab, required super.child});

  static TabNavigator? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TabNavigator>();

  @override
  bool updateShouldNotify(TabNavigator oldWidget) => true;
}
