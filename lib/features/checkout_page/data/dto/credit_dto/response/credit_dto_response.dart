
import 'package:flower_app/features/checkout_page/domain/entity/credit_order/response/credit_order_response_entity.dart';

class CreditOrderResponseDto extends CreditOrderResponseEntity {
  const CreditOrderResponseDto({
    required String message,
    required String sessionId,
    required String sessionUrl,
    required int amountTotal,
    required int amountSubtotal,
    required String currency,
    required String customerEmail,
    required int expiresAt,
    required String status,
  }) : super(
    message: message,
    sessionId: sessionId,
    sessionUrl: sessionUrl,
    amountTotal: amountTotal,
    amountSubtotal: amountSubtotal,
    currency: currency,
    customerEmail: customerEmail,
    expiresAt: expiresAt,
    status: status,
  );

  factory CreditOrderResponseDto.fromJson(Map<String, dynamic> json) {
    return CreditOrderResponseDto(
      message: json['message'],
      sessionId: json['sessionId'],
      sessionUrl: json['sessionUrl'],
      amountTotal: json['amountTotal'],
      amountSubtotal: json['amountSubtotal'],
      currency: json['currency'],
      customerEmail: json['customerEmail'],
      expiresAt: json['expiresAt'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sessionId': sessionId,
      'sessionUrl': sessionUrl,
      'amountTotal': amountTotal,
      'amountSubtotal': amountSubtotal,
      'currency': currency,
      'customerEmail': customerEmail,
      'expiresAt': expiresAt,
      'status': status,
    };
  }
}
