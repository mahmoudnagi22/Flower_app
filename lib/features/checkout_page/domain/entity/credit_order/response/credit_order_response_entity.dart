class CreditOrderResponseEntity {
  final String message;
  final String sessionId;
  final String sessionUrl;
  final int amountTotal;
  final int amountSubtotal;
  final String currency;
  final String customerEmail;
  final int expiresAt;
  final String status;

  const CreditOrderResponseEntity({
    required this.message,
    required this.sessionId,
    required this.sessionUrl,
    required this.amountTotal,
    required this.amountSubtotal,
    required this.currency,
    required this.customerEmail,
    required this.expiresAt,
    required this.status,
  });
}
