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

  static const scheduleCall = '/schedule-call';
  static const professional = '/professional';
  static const professionals = '/professionals';
  static const call = '/call';

  // Onboarding / professional setup
  static const roleSelection = '/role-selection';
  static const professionalKyc = '/professional-kyc';
  static const professionalKycRates = '/professional-kyc/rates';

  static const notifications = '/notifications';

  static const componentPreview = '/component-preview';
}
