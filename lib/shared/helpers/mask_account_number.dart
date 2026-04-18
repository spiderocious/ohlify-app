String maskAccountNumber(String account) {
  if (account.length < 4) return '****';
  return '${"*" * (account.length - 4)}${account.substring(account.length - 4)}';
}
