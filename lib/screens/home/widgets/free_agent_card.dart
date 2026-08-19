import 'package:flutter/material.dart';
import '../../../models/free_agent.dart';
import '../../../theme/app_theme.dart';

class FreeAgentCard extends StatelessWidget {
  final FreeAgent agent;

  const FreeAgentCard({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.secondaryGreen.withOpacity(0.15),
                child: Text(
                  agent.name.substring(0, 1),
                  style: const TextStyle(color: AppColors.primaryGreen, fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              if (agent.featured)
                const Padding(
                  padding: EdgeInsets.only(left: 6),
                  child: Icon(Icons.verified, size: 16, color: AppColors.secondaryGreen),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(agent.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
          const SizedBox(height: 2),
          Text(agent.profession, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.place_outlined, size: 13, color: AppColors.textMuted),
              const SizedBox(width: 2),
              Expanded(
                child: Text(agent.location, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: Color(0xFFF2B01E)),
              const SizedBox(width: 3),
              Text('${agent.rating}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              const SizedBox(width: 6),
              Text('(${agent.completedJobs})', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}
