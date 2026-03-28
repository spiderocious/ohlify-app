import 'package:ohlify/shared/types/types.dart';

/// Provides static mock data for all features during development.
/// Replace individual methods with real API calls when the backend is ready.
abstract final class MockService {
  static ScheduledCall? getScheduledCall() {
    return const ScheduledCall(
      id: 'call-001',
      calleeName: 'Chinedu Okezie',
      scheduledTime: '5 mins',
    );
  }

  static List<ProfessionalCategory> getCategories() {
    return const [
      ProfessionalCategory(label: 'All', value: 'all'),
      ProfessionalCategory(label: 'Lawyer', value: 'lawyer'),
      ProfessionalCategory(label: 'Podcaster', value: 'podcaster'),
      ProfessionalCategory(label: 'Architect', value: 'architect'),
      ProfessionalCategory(label: 'Finance', value: 'finance'),
      ProfessionalCategory(label: 'Health', value: 'health'),
      ProfessionalCategory(label: 'Career', value: 'career'),
    ];
  }

  static List<Professional> getProfessionals() {
    return const [
      Professional(
        id: 'p-001',
        name: 'Jocelyn Aminoff',
        role: 'Senior sales manager',
        rating: 4.9,
        reviewCount: 187,
      ),
      Professional(
        id: 'p-002',
        name: 'Lindsey Saris',
        role: 'Senior sales manager',
        rating: 4.9,
        reviewCount: 187,
      ),
      Professional(
        id: 'p-003',
        name: 'Charlie Mango',
        role: 'Senior sales manager',
        rating: 4.9,
        reviewCount: 187,
      ),
    ];
  }

  static List<UpcomingCall> getUpcomingCalls() {
    return const [
      UpcomingCall(
        id: 'uc-001',
        name: 'Tatiana Saris',
        role: 'Senior sales manager',
        rating: 4.9,
        reviewCount: 187,
      ),
      UpcomingCall(
        id: 'uc-002',
        name: 'Zaire Vetrovs',
        role: 'Senior sales manager',
        rating: 4.9,
        reviewCount: 187,
      ),
      UpcomingCall(
        id: 'uc-003',
        name: 'Carter Workman',
        role: 'Senior sales manager',
        rating: 4.9,
        reviewCount: 187,
      ),
    ];
  }
}
