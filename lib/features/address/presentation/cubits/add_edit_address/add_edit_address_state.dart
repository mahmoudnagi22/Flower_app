part of 'add_edit_address_cubit.dart';

@immutable
sealed class AddEditAddressState {}

final class AddEditAddressInitial extends AddEditAddressState {}
final class AddEditAddressLoading extends AddEditAddressState {}
final class AddEditAddressSuccess extends AddEditAddressState {}
final class AddEditAddressFailed extends AddEditAddressState {}
