enum VerificationLevel { basic, advanced, professional }

/// A "Free Agent" is a trusted local person on the ground who accepts
/// tasks and earns money — the agent-side user type from the PRD,
/// renamed to the project's preferred term.
class FreeAgent {
  final String id;
  final String name;
  final String photoUrl;
  final String country;
  final String city;
  final List<String> languages;
  final String profession;
  final double rating;
  final int completedJobs;
  final VerificationLevel verification;
  final String responseTime;
  final bool featured;

  const FreeAgent({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.country,
    required this.city,
    required this.languages,
    required this.profession,
    required this.rating,
    required this.completedJobs,
    required this.verification,
    required this.responseTime,
    this.featured = false,
  });

  String get location => '$city, $country';

  String get verificationLabel {
    switch (verification) {
      case VerificationLevel.basic:
        return 'Basic Verified';
      case VerificationLevel.advanced:
        return 'ID Verified';
      case VerificationLevel.professional:
        return 'Pro Verified';
    }
  }
}
