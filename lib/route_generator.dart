import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_blood/screens/blood_request_screen.dart';
import 'package:one_blood/screens/tab_screen.dart';
import 'package:one_blood/screens/setting_screen.dart';
import 'package:one_blood/screens/login.dart';
import 'package:one_blood/screens/profile_detail_screen.dart';
import 'package:one_blood/screens/sign_up_screen.dart';
import 'package:one_blood/screens/srch_result.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case TabScreen.id:
        return MaterialPageRoute(builder: (_) => TabScreen());
      case SignInScreen.id:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case SignUpScreen.id:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case UserDataScreen.id:
        return MaterialPageRoute(builder: (_) => UserDataScreen());
      case SettingScreen.id:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case SearchScreen.id:
        return MaterialPageRoute(
            builder: (_) => SearchScreen(blood: settings.arguments as String));
      case BloodRequestScreen.id:
        return MaterialPageRoute(builder: (_) => BloodRequestScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('Route Not Found.'),
          ),
        );
      },
    );
  }
}
