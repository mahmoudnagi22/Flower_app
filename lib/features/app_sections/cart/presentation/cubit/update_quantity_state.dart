part of 'update_quantity_cubit.dart';

class UpdateQuantityState extends Equatable{
  final Status updateStatus;
  final String? updateError;
  final UpdateQuantityResponseEntity? updateList;

  @override
  // TODO: implement props
  List<Object?> get props => [updateStatus,updateError,updateList];

  const UpdateQuantityState({
     this.updateStatus = Status.initial,
    this.updateError,
    this.updateList,
  });

  UpdateQuantityState copyWith({
    Status? updateStatus,
    String? updateError,
    UpdateQuantityResponseEntity? updateList,
  }) {
    return UpdateQuantityState(
      updateStatus: updateStatus ?? this.updateStatus,
      updateError: updateError ?? this.updateError,
      updateList: updateList ?? this.updateList,
    );
  }
}


