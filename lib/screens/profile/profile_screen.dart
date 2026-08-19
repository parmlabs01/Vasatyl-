import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primaryGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.primaryGreen,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 38,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 42, color: AppColors.primaryGreen),
                      ),
                      const SizedBox(height: 10),
                      const Text('Ada Eze', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.verified, size: 14, color: Colors.white),
                          SizedBox(width: 4),
                          Text('Client · ID Verified', style: TextStyle(color: Colors.white70, fontSize: 12.5)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _StatCard(label: 'Wallet Balance', value: '\$128.40')),
                      const SizedBox(width: 12),
                      Expanded(child: _StatCard(label: 'Reviews', value: '4.9 ★')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _MenuGroup(items: [
                    _MenuEntry(Icons.account_balance_wallet_outlined, 'Wallet'),
                    _MenuEntry(Icons.verified_user_outlined, 'Verification'),
                    _MenuEntry(Icons.star_border, 'Reviews'),
                  ]),
                  const SizedBox(height: 12),
                  _MenuGroup(items: [
                    _MenuEntry(Icons.badge_outlined, 'Become a Free Agent'),
                    _MenuEntry(Icons.language, 'Language & Region'),
                    _MenuEntry(Icons.notifications_outlined, 'Notifications'),
                  ]),
                  const SizedBox(height: 12),
                  _MenuGroup(items: [
                    _MenuEntry(Icons.settings_outlined, 'Settings'),
                    _MenuEntry(Icons.help_outline, 'Help & Support'),
                    _MenuEntry(Icons.logout, 'Log Out', destructive: true),
                  ]),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primaryGreen)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ],
        ),
      ),
    );
  }
}

class _MenuEntry {
  final IconData icon;
  final String label;
  final bool destructive;
  _MenuEntry(this.icon, this.label, {this.destructive = false});
}

class _MenuGroup extends StatelessWidget {
  final List<_MenuEntry> items;
  const _MenuGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: List.generate(items.length, (i) {
          final e = items[i];
          return Column(
            children: [
              ListTile(
                leading: Icon(e.icon, color: e.destructive ? AppColors.danger : AppColors.textPrimary),
                title: Text(e.label, style: TextStyle(fontWeight: FontWeight.w600, color: e.destructive ? AppColors.danger : AppColors.textPrimary)),
                trailing: e.destructive ? null : const Icon(Icons.chevron_right, color: AppColors.textMuted),
                onTap: () {},
              ),
              if (i != items.length - 1) const Divider(height: 1, indent: 56),
            ],
          );
        }),
      ),
    );
  }
}
