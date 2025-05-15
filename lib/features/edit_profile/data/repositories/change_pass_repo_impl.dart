import 'package:flower_app/features/edit_profile/data/data_sources/change_pass_ds_contract.dart';
import 'package:flower_app/features/edit_profile/domain/repositories/change_pass_repo_contract.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ChangePassRepoContract)
class ChangePassRepoImpl implements ChangePassRepoContract {
  final ChangePassDsContract changePassDsContract;

  ChangePassRepoImpl(this.changePassDsContract);

  @override
  Future<void> changePassword({
    required String token,
    required String currentPassword,
    required String newPassword,
  }) {
    return changePassDsContract.changePassword(
      token: token,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }
}
