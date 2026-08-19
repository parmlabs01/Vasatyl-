enum TaskStatus { posted, accepted, inProgress, submitted, underReview, completed, disputed, cancelled }

class VasatylTask {
  final String id;
  final String title;
  final String category;
  final String country;
  final String city;
  final double budget;
  final String currency;
  final DateTime deadline;
  final TaskStatus status;
  final bool urgent;

  const VasatylTask({
    required this.id,
    required this.title,
    required this.category,
    required this.country,
    required this.city,
    required this.budget,
    required this.deadline,
    this.currency = 'USD',
    this.status = TaskStatus.posted,
    this.urgent = false,
  });

  String get location => '$city, $country';

  String get statusLabel {
    switch (status) {
      case TaskStatus.posted:
        return 'Posted';
      case TaskStatus.accepted:
        return 'Accepted';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.submitted:
        return 'Submitted';
      case TaskStatus.underReview:
        return 'Under Review';
      case TaskStatus.completed:
        return 'Completed';
      case TaskStatus.disputed:
        return 'Disputed';
      case TaskStatus.cancelled:
        return 'Cancelled';
    }
  }
}
