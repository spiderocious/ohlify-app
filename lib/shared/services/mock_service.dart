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

  static List<ScheduledCallItem> getScheduledCalls() {
    return const [
      ScheduledCallItem(
        id: 'sc-001',
        name: 'Chinonso Eze',
        role: 'Senior sales manager',
        rating: 4.9,
        callType: CallType.video,
        time: '12:00PM',
        date: '23 Feb, 2026',
        duration: '25 mins',
        canReschedule: true,
      ),
      ScheduledCallItem(
        id: 'sc-002',
        name: 'Chinonso Eze',
        role: 'Senior sales manager',
        rating: 4.9,
        callType: CallType.video,
        time: '12:00PM',
        date: '23 Feb, 2026',
        duration: '25 mins',
        canReschedule: false,
      ),
      ScheduledCallItem(
        id: 'sc-003',
        name: 'Chinonso Eze',
        role: 'Senior sales manager',
        rating: 4.9,
        callType: CallType.audio,
        time: '12:00PM',
        date: '23 Feb, 2026',
        duration: '25 mins',
        canReschedule: false,
      ),
    ];
  }

  static List<CompletedCallGroup> getCompletedCalls() {
    return const [
      CompletedCallGroup(
        date: 'FEBRUARY 2, 2023',
        calls: [
          CompletedCallItem(
            id: 'cc-001',
            name: 'Chinonso Eze',
            callType: CallType.video,
            time: '03:02 PM',
            duration: '25 mins',
            amount: '₦20,000.00',
          ),
          CompletedCallItem(
            id: 'cc-002',
            name: 'Brandon Baptista',
            callType: CallType.audio,
            time: '03:02 PM',
            duration: '25 mins',
            amount: '₦20,000.00',
          ),
          CompletedCallItem(
            id: 'cc-003',
            name: 'Skylar Rosser',
            callType: CallType.video,
            time: '03:02 PM',
            duration: '25 mins',
            amount: '₦20,000.00',
          ),
          CompletedCallItem(
            id: 'cc-004',
            name: 'Wilson Vaccaro',
            callType: CallType.audio,
            time: '03:02 PM',
            duration: '25 mins',
            amount: '₦20,000.00',
          ),
          CompletedCallItem(
            id: 'cc-005',
            name: 'Kaiya Carder',
            callType: CallType.video,
            time: '03:02 PM',
            duration: '25 mins',
            amount: '₦20,000.00',
          ),
          CompletedCallItem(
            id: 'cc-006',
            name: 'Giana Dokidis',
            callType: CallType.audio,
            time: '03:02 PM',
            duration: '25 mins',
            amount: '₦20,000.00',
          ),
        ],
      ),
    ];
  }

  static CallStats getCallStats() {
    return const CallStats(total: 47, thisMonth: 47, thisWeek: 18);
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
