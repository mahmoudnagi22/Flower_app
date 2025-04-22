import 'package:flower_app/features/saved_address/data/models/address_model.dart';
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

  Future<void> addAddress(AddressModel address) async {
    emit(AddressLoading());
    try {
      await addAddressUsecase(address);
      await getAddresses();
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> updateAddress(AddressModel address) async {
    emit(AddressLoading());
    try {
      await updateAddressUsecase(address);
      await getAddresses();
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }

  Future<void> deleteAddress(AddressModel address) async {
    emit(AddressLoading());
    try {
      await deleteAddressUsecase(address);
      await getAddresses();
    } catch (e) {
      emit(AddressError(e.toString()));
    }
  }
}
