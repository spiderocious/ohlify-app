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

  static String getWalletBalance() => '₦560,894,393';

  static WalletStats getWalletStats() {
    return const WalletStats(thisWeek: 18, thisMonth: 47, totalCalls: 47);
  }

  static List<Transaction> getTransactions() {
    return const [
      Transaction(
        id: 'tx-001',
        type: TransactionType.withdrawalToBank,
        datetime: 'Feb 2, 2023, 09:56 AM',
        amount: '₦20,000.00',
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: 'tx-002',
        type: TransactionType.paymentAudioCall,
        datetime: 'Feb 2, 2023, 09:56 AM',
        amount: '-₦20,000.00',
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: 'tx-003',
        type: TransactionType.paymentVideoCall,
        datetime: 'Feb 2, 2023, 09:56 AM',
        amount: '-₦20,000.00',
        status: TransactionStatus.completed,
      ),
      Transaction(
        id: 'tx-004',
        type: TransactionType.scheduledAudioCall,
        datetime: 'Feb 2, 2023, 09:56 AM',
        amount: '+₦20,000.00',
        status: TransactionStatus.completed,
      ),
    ];
  }

  static String getProfessionalDetails(String id) {
    return 'Horem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, '
        'metus nec fringilla accumsan, risus sem lacus, ut interdum tellus '
        'elit sed risus. Maecenas condimentum velit, sit amet feugiat lectus. '
        'Class aptent taciti sociosqu ad litora torquent per conubia nostra, '
        'per inceptos himenaeos. Praesent auctor purus luctus enim egestas, '
        'ac scelerisque ante pulvinar.';
  }

  static CallDetail? getCallById(String id) {
    // Search scheduled calls first
    for (final c in getScheduledCalls()) {
      if (c.id == id) {
        return CallDetail(
          id: c.id,
          professionalId: 'p-007',
          name: c.name,
          role: c.role,
          rating: c.rating,
          callType: c.callType,
          status: CallStatus.upcoming,
          time: c.time,
          date: c.date,
          duration: c.duration,
          canJoin: !c.canReschedule,
          canReschedule: c.canReschedule,
          avatarUrl: c.avatarUrl,
        );
      }
    }
    // Then upcoming (home-screen cards)
    for (final c in getUpcomingCalls()) {
      if (c.id == id) {
        return CallDetail(
          id: c.id,
          professionalId: 'p-007',
          name: c.name,
          role: c.role,
          rating: c.rating,
          callType: CallType.video,
          status: CallStatus.upcoming,
          time: '12:00 PM',
          date: '23 Feb, 2026',
          duration: '25 mins',
          canJoin: false,
          canReschedule: true,
          avatarUrl: c.avatarUrl,
        );
      }
    }
    // Then completed
    for (final group in getCompletedCalls()) {
      for (final c in group.calls) {
        if (c.id == id) {
          return CallDetail(
            id: c.id,
            professionalId: 'p-007',
            name: c.name,
            role: 'Senior sales manager',
            rating: 4.9,
            callType: c.callType,
            status: CallStatus.completed,
            time: c.time,
            date: group.date,
            duration: c.duration,
            canJoin: false,
            canReschedule: false,
            amount: c.amount,
            avatarUrl: c.avatarUrl,
          );
        }
      }
    }
    return null;
  }

  static List<CompletedCallItem> getCallHistoryWithProfessional(
    String professionalId,
  ) {
    return const [
      CompletedCallItem(
        id: 'h-001',
        name: 'Previous video call',
        callType: CallType.video,
        time: '03:02 PM',
        duration: '25 mins',
        amount: '₦20,000.00',
      ),
      CompletedCallItem(
        id: 'h-002',
        name: 'Previous audio call',
        callType: CallType.audio,
        time: '11:15 AM',
        duration: '10 mins',
        amount: '₦10,800.00',
      ),
      CompletedCallItem(
        id: 'h-003',
        name: 'Previous video call',
        callType: CallType.video,
        time: '05:40 PM',
        duration: '25 mins',
        amount: '₦20,000.00',
      ),
    ];
  }

  static List<Review> getProfessionalReviews(String id) {
    return const [
      Review(
        id: 'rv-001',
        authorName: 'Adaeze Umeh',
        rating: 5.0,
        comment:
            'Excellent session! He gave me very actionable advice on pricing '
            'and positioning. Will definitely book again.',
        timeAgo: '2 days ago',
      ),
      Review(
        id: 'rv-002',
        authorName: 'Tunde Bakare',
        rating: 4.8,
        comment:
            'Very knowledgeable and patient. Answered all my questions clearly '
            'and gave me a roadmap I can actually follow.',
        timeAgo: '1 week ago',
      ),
      Review(
        id: 'rv-003',
        authorName: 'Sarah Johnson',
        rating: 4.9,
        comment:
            'Great call. Felt like talking to a mentor who genuinely cares. '
            'Worth every naira.',
        timeAgo: '3 weeks ago',
      ),
    ];
  }

  static List<ProfessionalRate> getProfessionalRates(String id) {
    return const [
      ProfessionalRate(callType: CallType.audio, durationMinutes: 10, price: '₦ 10,800'),
      ProfessionalRate(callType: CallType.audio, durationMinutes: 25, price: '₦ 10,800'),
      ProfessionalRate(callType: CallType.video, durationMinutes: 10, price: '₦ 10,800'),
      ProfessionalRate(callType: CallType.video, durationMinutes: 25, price: '₦ 10,800'),
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
        basePrice: 10800,
      ),
      Professional(
        id: 'p-002',
        name: 'Lindsey Saris',
        role: 'Senior sales manager',
        rating: 4.7,
        reviewCount: 142,
        basePrice: 8500,
      ),
      Professional(
        id: 'p-003',
        name: 'Charlie Mango',
        role: 'Senior sales manager',
        rating: 4.8,
        reviewCount: 203,
        basePrice: 12500,
      ),
      Professional(
        id: 'p-004',
        name: 'Adaeze Umeh',
        role: 'Brand strategist',
        rating: 4.6,
        reviewCount: 98,
        basePrice: 7200,
      ),
      Professional(
        id: 'p-005',
        name: 'Tunde Bakare',
        role: 'Financial advisor',
        rating: 4.9,
        reviewCount: 256,
        basePrice: 15000,
      ),
      Professional(
        id: 'p-006',
        name: 'Sarah Johnson',
        role: 'Career coach',
        rating: 4.5,
        reviewCount: 74,
        basePrice: 6500,
      ),
      Professional(
        id: 'p-007',
        name: 'Kehinde Osinbajo',
        role: 'Senior sales manager',
        rating: 4.9,
        reviewCount: 312,
        basePrice: 11000,
      ),
      Professional(
        id: 'p-008',
        name: 'Morenike Adeyemi',
        role: 'Product designer',
        rating: 4.7,
        reviewCount: 165,
        basePrice: 9200,
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
