import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';
import 'widgets/location_bar.dart';
import 'widgets/section_header.dart';
import 'widgets/free_agent_card.dart';
import 'widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _location = 'Enugu, Nigeria';

  void _changeLocation() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => _LocationPicker(current: _location),
    );
    if (result != null) setState(() => _location = result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFFF4F7F5),
      drawer: const _MainDrawer(),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(const Duration(milliseconds: 600)),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.primaryGreen,
                child: Column(
                  children: [
                    LocationBar(
                      location: _location,
                      onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
                      onLocationTap: _changeLocation,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Find a Free Agent or task...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Nearby Free Agents', onSeeAll: () {}),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.nearbyFreeAgents.length,
                  itemBuilder: (context, i) => FreeAgentCard(agent: MockData.nearbyFreeAgents[i]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Urgent Tasks', onSeeAll: () {}),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 148,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.urgentTasks.length,
                  itemBuilder: (context, i) => TaskCard(task: MockData.urgentTasks[i]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Featured Free Agents', onSeeAll: () {}),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.featuredFreeAgents.length,
                  itemBuilder: (context, i) => FreeAgentCard(agent: MockData.featuredFreeAgents[i]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Recommended Tasks', onSeeAll: () {}),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 148,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.recommendedTasks.length,
                  itemBuilder: (context, i) => TaskCard(task: MockData.recommendedTasks[i]),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Trending Categories'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.trendingCategories.length,
                  itemBuilder: (context, i) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFE0E6E3)),
                    ),
                    child: Text(MockData.trendingCategories[i], style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SectionHeader(title: 'Popular Locations'),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: MockData.popularLocations.length,
                  itemBuilder: (context, i) => Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreen.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.public, size: 14, color: AppColors.primaryGreen),
                        const SizedBox(width: 6),
                        Text(MockData.popularLocations[i], style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: AppColors.primaryGreen)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 90)),
          ],
        ),
      ),
    );
  }
}

class _MainDrawer extends StatelessWidget {
  const _MainDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              color: AppColors.primaryGreen,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/vasatyl_logo.png', height: 44),
                  const SizedBox(height: 12),
                  const Text('Vasatyl', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                  const Text('One Big World.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
            ),
            const _DrawerItem(icon: Icons.account_balance_wallet_outlined, label: 'Wallet'),
            const _DrawerItem(icon: Icons.verified_user_outlined, label: 'Verification'),
            const _DrawerItem(icon: Icons.star_border, label: 'Reviews'),
            const _DrawerItem(icon: Icons.badge_outlined, label: 'Become a Free Agent'),
            const _DrawerItem(icon: Icons.settings_outlined, label: 'Settings'),
            const Spacer(),
            const _DrawerItem(icon: Icons.help_outline, label: 'Help & Support'),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  const _DrawerItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: () => Navigator.pop(context),
    );
  }
}

class _LocationPicker extends StatelessWidget {
  final String current;
  const _LocationPicker({required this.current});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Change location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...MockData.popularLocations.map(
              (loc) => ListTile(
                leading: const Icon(Icons.place_outlined, color: AppColors.primaryGreen),
                title: Text(loc),
                trailing: loc == current ? const Icon(Icons.check, color: AppColors.primaryGreen) : null,
                onTap: () => Navigator.pop(context, loc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
