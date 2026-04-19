abstract final class AppRoutes {
  static const root = '/';
  static const onboarding = '/onboarding';
  static const register = '/register';
  static const createPassword = '/register/create-password';
  static const verifyOtp = '/register/verify-otp';
  static const login = '/login';
  static const forgotPassword = '/forgot-password';
  static const forgotPasswordVerifyOtp = '/forgot-password/verify-otp';
  static const resetPassword = '/forgot-password/reset-password';

  // Main app shell
  static const home = '/home';
  static const calls = '/calls';
  static const wallet = '/wallet';
  static const profile = '/profile';

  // Profile sub-screens
  static const profilePersonalInfo = '/profile/personal-info';
  static const profileRates = '/profile/rates';
  static const profileBankAccount = '/profile/bank-account';
  static const profileChangePassword = '/profile/change-password';
  static const profileNotifications = '/profile/notifications';
  static const profileHelpDesk = '/profile/help-desk';
  static const profilePrivacyPolicy = '/profile/privacy-policy';
  static const profileEula = '/profile/eula';
  static const profileTerms = '/profile/terms';

  static const scheduleCall = '/schedule-call';
  static const professional = '/professional';
  static const professionals = '/professionals';
  static const call = '/call';

  // Live call session: /call/session/:role/:kind/:selfId/:peerId/:sessionId
  static const callSessionBase = '/call/session';

  // Onboarding / professional setup
  static const roleSelection = '/role-selection';
  static const professionalKyc = '/professional-kyc';
  static const professionalKycRates = '/professional-kyc/rates';
  static const clientKyc = '/client-kyc';

  static const notifications = '/notifications';

  static const componentPreview = '/component-preview';
}
