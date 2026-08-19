import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../models/vasatyl_task.dart';
import '../../theme/app_theme.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final active = MockData.recommendedTasks;
    final completed = MockData.urgentTasks;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('History'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'Active'), Tab(text: 'Completed'), Tab(text: 'Payments')],
          ),
        ),
        body: TabBarView(
          children: [
            _TaskHistoryList(tasks: active),
            _TaskHistoryList(tasks: completed, forceStatus: TaskStatus.completed),
            const _PaymentsList(),
          ],
        ),
      ),
    );
  }
}

class _TaskHistoryList extends StatelessWidget {
  final List<VasatylTask> tasks;
  final TaskStatus? forceStatus;
  const _TaskHistoryList({required this.tasks, this.forceStatus});

  Color _statusColor(TaskStatus s) {
    switch (s) {
      case TaskStatus.completed:
        return AppColors.secondaryGreen;
      case TaskStatus.disputed:
        return AppColors.danger;
      case TaskStatus.inProgress:
      case TaskStatus.accepted:
        return AppColors.warning;
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks here yet', style: TextStyle(color: AppColors.textMuted)));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final t = tasks[i];
        final status = forceStatus ?? t.status;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5)),
                      const SizedBox(height: 4),
                      Text(t.location, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$${t.budget.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.primaryGreen)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: _statusColor(status).withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        forceStatus != null ? 'Completed' : t.statusLabel,
                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _statusColor(status)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PaymentsList extends StatelessWidget {
  const _PaymentsList();

  @override
  Widget build(BuildContext context) {
    final payments = [
      ('Escrow funded — Apartment inspection', '-\$90.00', Icons.arrow_upward, AppColors.danger),
      ('Payout — Notary document pickup', '+\$65.00', Icons.arrow_downward, AppColors.secondaryGreen),
      ('Escrow refund — Cancelled task', '+\$40.00', Icons.arrow_downward, AppColors.secondaryGreen),
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: payments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) {
        final (title, amount, icon, color) = payments[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(backgroundColor: color.withOpacity(0.12), child: Icon(icon, color: color, size: 18)),
            title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.w800, color: color)),
          ),
        );
      },
    );
  }
}
