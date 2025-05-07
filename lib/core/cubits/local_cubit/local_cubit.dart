import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../features/localization/domain/use_cases/get_language.dart';
import '../../../features/localization/domain/use_cases/set_language.dart';

part 'local_state.dart';

@injectable
class LocalizationCubit extends Cubit<Localization> {
  final GetLanguageUseCase _getLocalUseCase;
  final SetLanguageUseCase _setLocalUseCase;

  LocalizationCubit(this._getLocalUseCase, this._setLocalUseCase) : super(Localization("en")) {
    loadLanguage();
  }

  static LocalizationCubit get(context) => BlocProvider.of(context);

  Future<void> loadLanguage() async {
    final lang = await _getLocalUseCase.call() ?? "en";
    emit(Localization(lang));
  }

  void changeLanguage(String language) {
    _setLocalUseCase.call(language);
    emit(Localization(language));
  }
}
