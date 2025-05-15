import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';

abstract class AddressState {}

class AddressInitial extends AddressState {}

class AddressLoading extends AddressState {}

class AddressSuccess extends AddressState {
  final List<AddressEntity> addresses;
  AddressSuccess(this.addresses);

}

class AddressError extends AddressState {
  final String message;
  AddressError(this.message);
}
