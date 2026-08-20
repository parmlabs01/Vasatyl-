import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/mock_data.dart';

/// A stylized, dark "night map" view — inspired by the Snap Map look:
/// silhouette buildings, avatar pins for people, category filter chips up
/// top, and a friends/agents strip along the bottom. This is a visual
/// placeholder; swap in `google_maps_flutter` + real tiles when ready and
/// keep this layer of avatar pins/chips/strip on top of it.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int _selectedFilter = 0;
  static const _filters = [
    ('Memories', Icons.collections_bookmark_outlined),
    ('Nearby', Icons.near_me_outlined),
    ('Popular', Icons.local_fire_department_outlined),
    ('Favorites', Icons.favorite_border),
    ('Urgent', Icons.bolt),
  ];

  @override
  Widget build(BuildContext context) {
    final agents = MockData.featuredFreeAgents + MockData.nearbyFreeAgents;
    final tasks = MockData.urgentTasks;

    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      body: Stack(
        children: [
          // Dark "3D" building silhouette base map.
          Positioned.fill(
            child: CustomPaint(painter: _NightMapPainter()),
          ),

          // Free Agent + task pins scattered on the map.
          ...List.generate(agents.length, (i) {
            final a = agents[i];
            return Positioned(
              left: 40.0 + (i * 95) % 260,
              top: 190.0 + (i * 130) % 420,
              child: _AvatarPin(label: a.name.split(' ').first, initial: a.name.substring(0, 1)),
            );
          }),
          ...List.generate(tasks.length, (i) {
            final t = tasks[i];
            return Positioned(
              right: 30.0 + (i * 110) % 220,
              bottom: 220.0 + (i * 90) % 300,
              child: _TaskPin(label: t.category.split(' ').first),
            );
          }),

          // Top bar: user avatar, location + weather.
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white24, width: 2),
                      color: const Color(0xFF1B2438),
                    ),
                    child: const Icon(Icons.person, color: Colors.white70, size: 24),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Enugu', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
                      Row(
                        children: const [
                          Icon(Icons.cloud_outlined, color: Colors.white70, size: 16),
                          SizedBox(width: 4),
                          Text('75°F', style: TextStyle(color: Colors.white70, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Filter chip row.
          Positioned(
            top: 78,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                itemBuilder: (context, i) {
                  final selected = _selectedFilter == i;
                  final (label, icon) = _filters[i];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      selected: selected,
                      onSelected: (_) => setState(() => _selectedFilter = i),
                      label: Text(label),
                      avatar: Icon(icon, size: 16, color: selected ? Colors.black : Colors.white70),
                      labelStyle: TextStyle(
                        color: selected ? Colors.black : Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.5,
                      ),
                      backgroundColor: const Color(0xCC1B2438),
                      selectedColor: Colors.white,
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                  );
                },
              ),
            ),
          ),

          // Right-side tool stack: layers, compass.
          Positioned(
            right: 14,
            bottom: 150,
            child: Column(
              children: [
                _ToolButton(icon: Icons.layers_outlined, onTap: () {}),
                const SizedBox(height: 10),
                _ToolButton(icon: Icons.explore_outlined, onTap: () {}),
              ],
            ),
          ),

          // Bottom strip: Free Agents near you, like a friends carousel.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xE60B1220)],
                ),
              ),
              child: SizedBox(
                height: 64,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: agents.length,
                  itemBuilder: (context, i) {
                    final a = agents[i];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: const Color(0xFF1B2438),
                            child: Text(a.name.substring(0, 1), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarPin extends StatelessWidget {
  final String label;
  final String initial;
  const _AvatarPin({required this.label, required this.initial});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.5),
            color: const Color(0xFF1B2438),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: Center(
            child: Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16)),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: const Color(0xCC0B1220), borderRadius: BorderRadius.circular(10)),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _TaskPin extends StatelessWidget {
  final String label;
  const _TaskPin({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFFE0533D),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))],
          ),
          child: const Icon(Icons.bolt, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: const Color(0xCC0B1220), borderRadius: BorderRadius.circular(10)),
          child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _ToolButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _ToolButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xCC1B2438),
          border: Border.all(color: Colors.white24),
        ),
        child: Icon(icon, color: Colors.white70, size: 20),
      ),
    );
  }
}

/// Paints angled building-block silhouettes over a dark navy base, plus a
/// couple of soft glowing road lines, to suggest a Snap-Map-style night map.
class _NightMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = const Color(0xFF0B1220);
    canvas.drawRect(Offset.zero & size, bg);

    final buildingPaint = Paint()..color = const Color(0xFF1B2438);
    final edgePaint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final rnd = math.Random(42);
    const rows = 14;
    const cols = 8;
    final cellW = size.width / cols;
    final cellH = size.height / rows;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if (rnd.nextDouble() < 0.35) continue; // gaps = "streets"
        final x = c * cellW + rnd.nextDouble() * 6;
        final y = r * cellH + rnd.nextDouble() * 6;
        final w = cellW * (0.55 + rnd.nextDouble() * 0.35);
        final h = cellH * (0.55 + rnd.nextDouble() * 0.35);
        final rect = Rect.fromLTWH(x, y, w, h);
        final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(2));
        canvas.drawRRect(rrect, buildingPaint);
        canvas.drawRRect(rrect, edgePaint);
      }
    }

    // A couple of diagonal "roads" with a soft glow, like the orange-lit
    // streets on Snap Map.
    final roadPaint = Paint()
      ..color = const Color(0xFF2A3450)
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(size.width * 0.15, 0), Offset(size.width * 0.55, size.height), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.35), Offset(size.width, size.height * 0.55), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
