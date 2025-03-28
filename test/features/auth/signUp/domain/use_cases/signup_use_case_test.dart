import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_request_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';
import 'package:flower_app/features/auth/signUp/domain/repositories/signup_repo.dart';
import 'package:flower_app/features/auth/signUp/domain/use_cases/signup_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_use_case_test.mocks.dart';

@GenerateMocks([SignupRepo])
void main() {
  late MockSignupRepo repo;
  late SignupUseCase signupUseCase;

  setUp(() {
    repo = MockSignupRepo();
    signupUseCase = SignupUseCase(signupRepo: repo);
  });

  group(
    'Test SignUp Use Case class ',
    () {
      test('when call call function then should be return success', () async {
        // Arrange

        var expectedResult = ApiSuccessResult<SignupResponseEntity>(
          data: SignupResponseEntity(),
        );
        provideDummy<ApiResult<SignupResponseEntity>>(expectedResult);
        when(repo.signup(any)).thenAnswer((_) async => expectedResult);
        SignupRequestEntity request = SignupRequestEntity(
          firstName: "ahmed",
          lastName: "abd",
          email: "ahmedAbd@gmail.com",
          password: "@password123",
          rePassword: "@password123",
          phone: "1234567890",
          gender: "Male",
        );
        // Act
        var actual = await signupUseCase.call(request);

        // Assert
        verify(repo.signup(request)).called(1);
        expect(actual, isA<ApiSuccessResult<SignupResponseEntity>>());
      });

      test('when call call function then should be return error', () async {
        // Arrange
        SignupRequestEntity request = SignupRequestEntity(
          firstName: "ahmed",
          lastName: "abd",
          email: "ahmedAbdgmail.com",
          password: "@password123",
          rePassword: "@password123",
          phone: "1234567890",
          gender: "Male",
        );
        Failures failures = Failures(errorMessage: 'signup failed');
        var expectedResult = ApiErrorResult<SignupResponseEntity>(
          failures: failures,
        );

        provideDummy<ApiResult<SignupResponseEntity>>(expectedResult);
        when(repo.signup(any)).thenAnswer((_) async => expectedResult);

        var signupUseCase = SignupUseCase(signupRepo: repo);

        // Act
        var actual = await signupUseCase.call(request);

        // Assert
        verify(repo.signup(request)).called(1);
        expect(actual, isA<ApiErrorResult<SignupResponseEntity>>());
      });
    },
  );
}
