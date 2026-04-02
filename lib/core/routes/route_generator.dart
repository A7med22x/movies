import 'package:flutter/material.dart';
import 'package:movies/core/routes/routes.dart';
import 'package:movies/features/auth/view/screens/forget_password_screen.dart';
import 'package:movies/features/auth/view/screens/login_screen.dart';
import 'package:movies/features/auth/view/screens/register_screen.dart';
import 'package:movies/features/home/view/screens/home_screen.dart';
import 'package:movies/features/movie_details/view/screens/movie_details_screen.dart';
import 'package:movies/features/onBoarding/view/screens/on_boarding_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());      
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.movieDetails:
        final movieId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(movieId: movieId),
        );
      default:
        return _undefinedRoute();
    }
  }

  static Route<dynamic> _undefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
