import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flower_app/core/routes_manager/route_generator.dart';
import 'package:flower_app/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/cubits/local_cubit/local_cubit.dart';
import 'core/di/di.dart';
import 'core/l10n/app_localizations.dart';
import 'features/auth/change_password/data/api_call/api_call.dart';
import 'features/localization/domain/use_cases/get_language.dart';
import 'features/localization/domain/use_cases/set_language.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AppBlocObserver();
  await loadSavedUserToken();
  configureDependencies();
  runApp(const FlowerApp());

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.instance.getToken().then((token) {
    print("FCM Token: $token");
  });

}

class FlowerApp extends StatelessWidget {
  const FlowerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LocalizationCubit(
                getIt<GetLanguageUseCase>(),
                getIt<SetLanguageUseCase>(),
              ),
        ),
        BlocProvider(create: (context) => LocalizationCubit(getIt<GetLanguageUseCase>(), getIt<SetLanguageUseCase>())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,

        builder:
            (context, child) => BlocBuilder<LocalizationCubit, Localization>(
              builder: (context, state) {
                return MaterialApp(
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: Locale(state.language),
                  debugShowCheckedModeBanner: false,
                  home: child,
                  onGenerateRoute: RouteGenerator.getRoute,
                  initialRoute: Routes.splash,

                );
              },
            ),
      ),
    );
  }
}

//flutter packages pub run build_runner watch
//flutter packages pub run build_runner build
