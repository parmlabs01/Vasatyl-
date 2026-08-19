import 'package:flutter/material.dart';
import '../../../models/vasatyl_task.dart';
import '../../../theme/app_theme.dart';

class TaskCard extends StatelessWidget {
  final VasatylTask task;

  const TaskCard({super.key, required this.task});

  String _dueLabel() {
    final diff = task.deadline.difference(DateTime.now());
    if (diff.inHours < 24) return 'Due in ${diff.inHours}h';
    return 'Due in ${diff.inDays}d';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreen.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(task.category, style: const TextStyle(fontSize: 10, color: AppColors.primaryGreen, fontWeight: FontWeight.w600)),
              ),
              const Spacer(),
              if (task.urgent)
                const Icon(Icons.bolt, size: 16, color: AppColors.warning),
            ],
          ),
          const SizedBox(height: 8),
          Text(task.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.place_outlined, size: 13, color: AppColors.textMuted),
              const SizedBox(width: 2),
              Expanded(child: Text(task.location, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11.5, color: AppColors.textMuted))),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${task.budget.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: AppColors.primaryGreen)),
              Text(_dueLabel(), style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}
