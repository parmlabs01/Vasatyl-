import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  static const _categoryGroups = {
    'Religious & Cultural Services': Icons.temple_buddhist_outlined,
    'Personal Services': Icons.favorite_border,
    'Property & Asset Services': Icons.home_work_outlined,
    'Administrative Services': Icons.description_outlined,
    'Research Services': Icons.travel_explore,
    'Photography & Media': Icons.camera_alt_outlined,
    'Local Shopping': Icons.shopping_bag_outlined,
    'Humanitarian Services': Icons.volunteer_activism_outlined,
    'Business Services': Icons.business_center_outlined,
    'Technology Services': Icons.devices_other_outlined,
    'Education Services': Icons.school_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vasatyl Hub')),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Text(
                'Explore opportunities globally',
                style: TextStyle(fontSize: 15, color: AppColors.textMuted),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final entry = _categoryGroups.entries.elementAt(i);
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(entry.value, color: AppColors.primaryGreen, size: 26),
                        Text(entry.key, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
                      ],
                    ),
                  );
                },
                childCount: _categoryGroups.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
