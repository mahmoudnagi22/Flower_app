import 'package:bloc/bloc.dart';
import 'package:flower_app/features/address/data/models/address.dart';
import 'package:flower_app/features/address/domain/use_cases/add_address.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/models/api_result.dart';

part 'add_edit_address_state.dart';

class AddEditAddressCubit extends Cubit<AddEditAddressState> {
  AddEditAddressCubit(this._addAddressUseCase) : super(AddEditAddressInitial());
  final AddAddressUseCase _addAddressUseCase;
static AddEditAddressCubit get(context) => BlocProvider.of(context);
  Future<void> addAddress(Address params) async {
    emit(AddEditAddressLoading());

    final result = await _addAddressUseCase.call(params);
    if (result is ApiSuccessResult) {
      emit(AddEditAddressSuccess());
    } else {
      emit(AddEditAddressFailed());
    }
  }
}
