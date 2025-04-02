import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/repositories/signup_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../use_cases/signup_use_case_test.mocks.dart';

@GenerateMocks([SignupRepo])
void main() {
  late MockSignupRepo mockSignupRepo;
  final SignupRequestEntity requestEntity = SignupRequestEntity();
  final SignupResponseEntity responseEntity = SignupResponseEntity();
  setUpAll(
    () {
      mockSignupRepo = MockSignupRepo();
    },
  );
  test('TODO: Implement tests for signup_repo success ', () async {
    var expectedResult = ApiSuccessResult(data: responseEntity);
    provideDummy<ApiResult<SignupResponseEntity>>(expectedResult);
    when(mockSignupRepo.signup(requestEntity)).thenAnswer(
      (_) async => ApiSuccessResult(data: responseEntity),
    );
    final result = await mockSignupRepo.signup(requestEntity);

    expect(expectedResult, isA<ApiSuccessResult<SignupResponseEntity>>());
    verify(mockSignupRepo.signup(requestEntity)).called(1);
  });

  test('TODO: Implement tests for signup_repo error ', () async {
    // TODO:Arrange
    Failures failures = Failures(errorMessage: 'signup failed');
    var expectedResult = ApiErrorResult<SignupResponseEntity>(failures: failures);
    provideDummy<ApiResult<SignupResponseEntity>>(expectedResult);
    when(mockSignupRepo.signup(requestEntity)).thenAnswer(
      (_) async => expectedResult,
    );
    // TODO:Act
    final result = await mockSignupRepo.signup(requestEntity);
    // TODO:Assert
    expect(expectedResult, isA<ApiResult<SignupResponseEntity>>());
    verify(mockSignupRepo.signup(requestEntity)).called(1);
  });
}
