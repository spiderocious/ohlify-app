sealed class ValidationResult {
  const ValidationResult();
}

final class ValidationOk extends ValidationResult {
  const ValidationOk();
}

final class ValidationFailed extends ValidationResult {
  const ValidationFailed(this.message);
  final String message;
}
