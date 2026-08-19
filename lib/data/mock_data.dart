import '../models/free_agent.dart';
import '../models/vasatyl_task.dart';

/// Static sample data. Swap this out for real Supabase queries later —
/// see README.md for the suggested table shapes.
class MockData {
  MockData._();

  static final List<FreeAgent> nearbyFreeAgents = [
    const FreeAgent(
      id: 'fa_001',
      name: 'Chidera Okafor',
      photoUrl: '',
      country: 'Nigeria',
      city: 'Enugu',
      languages: ['English', 'Igbo'],
      profession: 'Errand & Delivery Agent',
      rating: 4.8,
      completedJobs: 132,
      verification: VerificationLevel.advanced,
      responseTime: '~15 min',
    ),
    const FreeAgent(
      id: 'fa_002',
      name: 'Amara Nwosu',
      photoUrl: '',
      country: 'Nigeria',
      city: 'Enugu',
      languages: ['English', 'Igbo', 'French'],
      profession: 'Personal Shopper',
      rating: 4.6,
      completedJobs: 58,
      verification: VerificationLevel.basic,
      responseTime: '~40 min',
    ),
  ];

  static final List<FreeAgent> featuredFreeAgents = [
    const FreeAgent(
      id: 'fa_101',
      name: 'Kenji Watanabe',
      photoUrl: '',
      country: 'Japan',
      city: 'Tokyo',
      languages: ['Japanese', 'English'],
      profession: 'Property Inspector',
      rating: 4.9,
      completedJobs: 401,
      verification: VerificationLevel.professional,
      responseTime: '~5 min',
      featured: true,
    ),
    const FreeAgent(
      id: 'fa_102',
      name: 'Giulia Romano',
      photoUrl: '',
      country: 'Italy',
      city: 'Rome',
      languages: ['Italian', 'English'],
      profession: 'Cultural Guide',
      rating: 5.0,
      completedJobs: 214,
      verification: VerificationLevel.professional,
      responseTime: '~10 min',
      featured: true,
    ),
    const FreeAgent(
      id: 'fa_103',
      name: 'Marcos Silva',
      photoUrl: '',
      country: 'Brazil',
      city: 'São Paulo',
      languages: ['Portuguese', 'English', 'Spanish'],
      profession: 'Researcher',
      rating: 4.7,
      completedJobs: 96,
      verification: VerificationLevel.advanced,
      responseTime: '~20 min',
      featured: true,
    ),
  ];

  static final List<VasatylTask> urgentTasks = [
    VasatylTask(
      id: 't_001',
      title: 'Pick up documents from a Tokyo notary office',
      category: 'Administrative Services',
      country: 'Japan',
      city: 'Tokyo',
      budget: 65,
      deadline: DateTime.now().add(const Duration(hours: 18)),
      urgent: true,
    ),
    VasatylTask(
      id: 't_002',
      title: 'Place flowers at a gravesite before Sunday',
      category: 'Religious & Cultural Services',
      country: 'Italy',
      city: 'Rome',
      budget: 40,
      deadline: DateTime.now().add(const Duration(hours: 30)),
      urgent: true,
    ),
  ];

  static final List<VasatylTask> recommendedTasks = [
    VasatylTask(
      id: 't_010',
      title: 'Inspect a 2-bedroom apartment before I rent it',
      category: 'Property & Asset Services',
      country: 'Brazil',
      city: 'São Paulo',
      budget: 90,
      deadline: DateTime.now().add(const Duration(days: 4)),
    ),
    VasatylTask(
      id: 't_011',
      title: 'Buy and ship regional spices from a local market',
      category: 'Local Shopping',
      country: 'Morocco',
      city: 'Marrakesh',
      budget: 55,
      deadline: DateTime.now().add(const Duration(days: 6)),
    ),
    VasatylTask(
      id: 't_012',
      title: 'Attend a court hearing and report back',
      category: 'Administrative Services',
      country: 'Canada',
      city: 'Toronto',
      budget: 150,
      deadline: DateTime.now().add(const Duration(days: 2)),
    ),
  ];

  static const List<String> trendingCategories = [
    'Religious & Cultural Services',
    'Property & Asset Services',
    'Photography & Media',
    'Research Services',
    'Local Shopping',
    'Technology Services',
  ];

  static const List<String> popularLocations = [
    'Lagos, Nigeria',
    'Tokyo, Japan',
    'Rome, Italy',
    'São Paulo, Brazil',
    'Toronto, Canada',
    'Dubai, UAE',
  ];
}
