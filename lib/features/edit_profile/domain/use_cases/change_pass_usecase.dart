import 'package:flower_app/features/edit_profile/domain/repositories/change_pass_repo_contract.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangePassUsecase {
  final ChangePassRepoContract changePassRepoContract;

  ChangePassUsecase(this.changePassRepoContract);

  Future<void> call({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) {
    return changePassRepoContract.changePassword(
      token: token,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
