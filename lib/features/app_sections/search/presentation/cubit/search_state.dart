part of 'search_cubit.dart';

class SearchState extends Equatable {
  final Status searchState;
  final String? searchError;
  final SearchEntity? searchList;

  @override
  List<Object?> get props => [searchState, searchError, searchList];

  const SearchState({
    this.searchState = Status.initial,
    this.searchError,
    this.searchList,
  });

  SearchState copyWith({
    Status? searchState,
    String? searchError,
    SearchEntity? searchList,
  }) {
    return SearchState(
      searchState: searchState ?? this.searchState,
      searchError: searchError ?? this.searchError,
      searchList: searchList ?? this.searchList,
    );
  }
}
