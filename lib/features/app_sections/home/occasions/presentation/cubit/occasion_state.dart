part of 'occasion_cubit.dart';

class OccasionState extends Equatable {
  final Status occasionState;
  final Status occasionByIdState;
  final String? occasionError;
  final String? occasionByIdError;
  final List<OccasionsEntity>? occasionList;
  final OccasionsByIdEntity? occasionById;

  const OccasionState({
    this.occasionState = Status.initial,
    this.occasionByIdState = Status.initial,
    this.occasionError,
    this.occasionByIdError,
    this.occasionList,
    this.occasionById,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
    occasionState,
    occasionByIdState,
    occasionError,
    occasionByIdError,
    occasionList,
    occasionById,
  ];

  OccasionState copyWith({
    Status? occasionState,
    Status? occasionByIdState,
    String? occasionError,
    String? occasionByIdError,
    List<OccasionsEntity>? occasionList,
    OccasionsByIdEntity? occasionById,
  }) {
    return OccasionState(
      occasionState: occasionState ?? this.occasionState,
      occasionByIdState: occasionByIdState ?? this.occasionByIdState,
      occasionError: occasionError ?? this.occasionError,
      occasionByIdError: occasionByIdError ?? this.occasionByIdError,
      occasionList: occasionList ?? this.occasionList,
      occasionById: occasionById ?? this.occasionById,
    );
  }
}
