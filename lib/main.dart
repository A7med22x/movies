import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies/core/routes/route_generator.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final hasSeenIntro = preferences.getBool('hasSeenIntro') ?? false;
  runApp(MoviesApp(hasSeenIntro: hasSeenIntro));
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
