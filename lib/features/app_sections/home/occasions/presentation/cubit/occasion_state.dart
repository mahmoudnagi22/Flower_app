part of 'occasion_cubit.dart';


 class OccasionState extends Equatable{
   final Status occasionState;
   final String? occasionError;
   final List<OccasionsEntity>? occasionList;

   const OccasionState({
     this.occasionState = Status.initial,
    this.occasionError,
    this.occasionList,
  });

   OccasionState copyWith({
    Status? occasionState,
    String? occasionError,
    List<OccasionsEntity>? occasionList,
  }) {
    return OccasionState(
      occasionState: occasionState ?? this.occasionState,
      occasionError: occasionError ?? this.occasionError,
      occasionList: occasionList ?? this.occasionList,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [occasionState,occasionError,occasionList];
}


