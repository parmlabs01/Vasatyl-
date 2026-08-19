import 'package:flutter/material.dart';

class LocationBar extends StatelessWidget {
  final String location;
  final VoidCallback onMenuTap;
  final VoidCallback onLocationTap;

  const LocationBar({
    super.key,
    required this.location,
    required this.onMenuTap,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 16, 8),
        child: Row(
          children: [
            IconButton(
              onPressed: onMenuTap,
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
            const Spacer(),
            InkWell(
              onTap: onLocationTap,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 16),
                    const SizedBox(width: 6),
                    Text(location, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
