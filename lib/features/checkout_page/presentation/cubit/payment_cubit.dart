import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PaymentMethodCubit extends Cubit<String> {
  PaymentMethodCubit() : super('Cash on delivery'); // الحالة الابتدائية

  void selectPaymentMethod(String method) {
    emit(method);
  }

  void selectMethod(String method) {
    emit(method); // نفس الوظيفة بس باسم مختلف لو محتاج تستخدمها
  }
}
