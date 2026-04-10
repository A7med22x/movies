import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/app_bloc_observer.dart';
import 'package:movies/core/di/service_locator.dart';
import 'package:movies/core/routes/route_generator.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/features/auth/view_model/auth_view_model.dart';
import 'package:movies/features/home/view_model/movies_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final hasSeenIntro = preferences.getBool('hasSeenIntro') ?? false;
  await dotenv.load(fileName: ".env");
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<MoviesViewModel>()),
        BlocProvider(create: (context) => serviceLocator<AuthViewModel>()),
      ],
      child: MoviesApp(hasSeenIntro: hasSeenIntro),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key, required this.hasSeenIntro});

  final bool hasSeenIntro;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: hasSeenIntro ? Routes.login : Routes.onBoarding,
      ),
    );
  }
}
