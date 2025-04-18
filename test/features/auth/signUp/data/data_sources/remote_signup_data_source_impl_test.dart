import 'package:flower_app/core/api_manager/api_manager.dart';
import 'package:flower_app/core/models/api_result.dart';
import 'package:flower_app/core/error/failers.dart';
import 'package:flower_app/core/utils/failures.dart';
import 'package:flower_app/features/auth/signUp/data/data_sources/remote_signup_data_source_contract.dart';
import 'package:flower_app/features/auth/signUp/data/data_sources/remote_signup_data_source_impl.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_request_dto.dart';
import 'package:flower_app/features/auth/signUp/data/models/signup_response_dto.dart';
import 'package:flower_app/features/auth/signUp/domain/entities/signup_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'remote_signup_data_source_impl_test.mocks.dart';




@GenerateMocks([ApiManager])
void main() {
  late RemoteSignupDataSourceContract dataSourceImpl;
  late ApiManager apiManager;
  SignupResponseDto responseDto = SignupResponseDto();
  SignupRequestDto requestDto = SignupRequestDto();
  setUp(() {
    apiManager = MockApiManager();
    dataSourceImpl = RemoteSignupDataSourceImpl(apiManager: apiManager);

  },);
  test('TODO: Implement tests for Success remote_signup_data_source_impl.dart', () async{

    // TODO: Arrange
    var result = ApiSuccessResult<SignupResponseDto>(data: responseDto);
    provideDummy<ApiResult<SignupResponseDto>>(result);
    when(apiManager.signup(requestDto)).thenAnswer((_) async => result,);

    // TODO: Act
    var actual = await dataSourceImpl.signup(requestDto);

    // TODO: Assert
    expect(actual, isA<ApiResult<SignupResponseEntity>>());
    verify(apiManager.signup(requestDto)).called(1);

  });

  test('TODO: Implement tests for Error remote_signup_data_source_impl.dart', () async{

    Failures failures = Failures(errorMessage: 'signup error');
    // TODO: Arrange

    var result = ApiErrorResult<SignupResponseDto>(failures: failures);
    provideDummy<ApiResult<SignupResponseDto>>(result);
    when(apiManager.signup(requestDto)).thenAnswer((_) async => result,);

    // TODO: Act
    var actual = await dataSourceImpl.signup(requestDto);

    // TODO: Assert
    expect(actual, isA<ApiResult<SignupResponseEntity>>());
    verify(apiManager.signup(requestDto)).called(1);

  });

}