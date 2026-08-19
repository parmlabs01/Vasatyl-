import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../theme/app_theme.dart';

/// Placeholder for the real Google Maps integration (see PRD's technical
/// stack). Shows Free Agents and tasks as a simple pin list until a maps
/// package + API key are wired in.
class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Stack(
        children: [
          Container(
            color: const Color(0xFFE7EFEA),
            child: CustomPaint(painter: _GridPainter(), child: const SizedBox.expand()),
          ),
          ...List.generate(MockData.featuredFreeAgents.length, (i) {
            final agent = MockData.featuredFreeAgents[i];
            return Positioned(
              left: 60.0 + (i * 90),
              top: 140.0 + (i * 70),
              child: _MapPin(label: agent.city, color: AppColors.primaryGreen),
            );
          }),
          ...List.generate(MockData.urgentTasks.length, (i) {
            final task = MockData.urgentTasks[i];
            return Positioned(
              right: 50.0 + (i * 80),
              bottom: 180.0 + (i * 60),
              child: _MapPin(label: task.city, color: AppColors.danger, icon: Icons.bolt),
            );
          }),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: AppColors.primaryGreen),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'Green pins are Free Agents, red pins are urgent tasks near you.',
                        style: TextStyle(fontSize: 12.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;

  const _MapPin({required this.label, required this.color, this.icon = Icons.person_pin_circle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 34),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4),
          ]),
          child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD3E2DA)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
