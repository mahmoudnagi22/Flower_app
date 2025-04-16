class Failures {
  final String errorMessage;

  Failures({required this.errorMessage});

  @override
  String toString() => errorMessage;
}

class NetworkError extends Failures {
  NetworkError({required super.errorMessage});
}

class ServerError extends Failures {
  ServerError({required super.errorMessage});
}

class CustomError extends Failures {
  CustomError({required super.errorMessage});
}
