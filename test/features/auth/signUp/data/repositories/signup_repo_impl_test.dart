

import 'package:flower_app/core/api_manager/api_result.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/signUp/data/data_sources/remote_signup_data_source_contract.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/repositories/signup_repo_impl.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signup_repo_impl_test.mocks.dart';

@GenerateMocks([RemoteSignupDataSourceContract])
void main() {
  late MockRemoteSignupDataSourceContract mockDataSource;
  late SignupRepoImpl signupRepo;
  SignupResponseEntity responseEntity = SignupResponseEntity();
  SignupRequestDto request = SignupRequestDto();

  setUpAll(() {
    mockDataSource = MockRemoteSignupDataSourceContract();
    signupRepo = SignupRepoImpl(remoteSignupDataSourceContract: mockDataSource);
  },);
  test('TODO: Implement tests for Success signup_repo_impl.dart', () async{
    // TODO: Arrange
    var expectedResult = ApiSuccessResult<SignupResponseEntity>(data: responseEntity);
    provideDummy<ApiResult<SignupResponseEntity>>(expectedResult);
    when(mockDataSource.signup(any)).thenAnswer((_)  async =>  expectedResult,);
    //TODO: Act
    var result = await signupRepo.signup(request);
    //TODO: Assert
    expect(result, isA<ApiSuccessResult<SignupResponseEntity>>());
    verify(mockDataSource.signup(any)).called(1);

  });

  test('TODO: Implement tests for Error signup_repo_impl.dart', () async{
    // TODO: Arrange
    Failures failures = Failures(errorMessage: 'signup failed');
    var expectedResult = ApiErrorResult<SignupResponseEntity>(failures: failures);
    provideDummy<ApiResult<SignupResponseEntity>>(expectedResult);
    when(mockDataSource.signup(any)).thenAnswer((_)  async =>  expectedResult,);
    //TODO: Act
    var result = await signupRepo.signup(request);
    //TODO: Assert
    expect(result, isA<ApiErrorResult<SignupResponseEntity>>());
    verify(mockDataSource.signup(any)).called(1);

  });
}