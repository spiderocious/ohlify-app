import 'package:ohlify/shared/notifiers/modal_notifier.dart';
import 'package:ohlify/shared/notifiers/toast_notifier.dart';
import 'package:ohlify/shared/services/services.dart';
import 'package:ohlify/ui/widgets/verify_otp_form/verify_otp_form.dart';

/// Opens an OTP verification modal. Invokes [onVerified] once the user
/// enters the expected code. In mock mode any 6-digit input succeeds.
///
/// The callback is fired after the modal has fully dismissed so chained
/// modals (feedback, follow-up forms) don't overlap.
void showOtpGate({
  required String channelHint,
  required void Function() onVerified,
}) {
  var verified = false;
  DrawerHandle? handle;
  handle = DrawerService.instance.showCustomModal(
    'Verify it\'s you',
    (_, _) => VerifyOtpForm(
      channelHint: channelHint,
      onResend: () => DrawerService.instance.toast(
        'Code resent',
        options: const ToastOptions(type: ToastType.info),
      ),
      onVerify: (_) {
        verified = true;
        handle?.dismiss();
      },
    ),
    options: const CustomModalOptions(position: ModalPosition.center),
  );

  handle.onDismissed.then((_) {
    if (verified) onVerified();
  });
}
