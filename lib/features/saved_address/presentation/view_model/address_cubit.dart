import 'package:flower_app/features/saved_address/domain/entities/address_entity.dart';
import 'package:flower_app/features/saved_address/domain/usecases/add_address_usecase.dart';
import 'package:flower_app/features/saved_address/domain/usecases/delete_address_usecase.dart';
import 'package:flower_app/features/saved_address/domain/usecases/get_addresses_usecase.dart';
import 'package:flower_app/features/saved_address/domain/usecases/update_address_usecase.dart';
import 'package:flower_app/features/saved_address/presentation/view_model/address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  final AddAddressUsecase addAddressUsecase;
  final GetAddressesUsecase getAddressesUsecase;
  final UpdateAddressUsecase updateAddressUsecase;
  final DeleteAddressUsecase deleteAddressUsecase;

  AddressCubit(
    this.addAddressUsecase,
    this.getAddressesUsecase,
    this.updateAddressUsecase,
    this.deleteAddressUsecase,
  ) : super(AddressInitial());

  Future<void> getAddresses() async {
    emit(AddressLoading());
    try {
      final addresses = await getAddressesUsecase();
      emit(AddressSuccess(addresses));
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> addAddress(AddressEntity address) async {
    emit(AddressLoading());
    try {
      await addAddressUsecase(address);
      await getAddresses();
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> updateAddress(AddressEntity address) async {
    emit(AddressLoading());
    try {
      await updateAddressUsecase(address);
      await getAddresses();
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> deleteAddress(int addressId) async {
    emit(AddressLoading());
    try {
      await deleteAddressUsecase(addressId);
      await getAddresses();
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}
