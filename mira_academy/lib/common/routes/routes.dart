// ignore_for_file: curly_braces_in_flow_control_structures, avoid_print

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mira_academy/common/routes/app_routes.dart';
import 'package:mira_academy/global.dart';
import 'package:mira_academy/pages/application/application.dart';
import 'package:mira_academy/pages/sign_in/sign_in.dart';
import 'package:mira_academy/pages/sign_up/sign_up.dart';
import 'package:mira_academy/pages/welcome/welcome.dart';

class AppPage {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(
        path: AppRoutesNames.WELCOME,
        page: const Welcome(),
      ),
      RouteEntity(
        path: AppRoutesNames.SIGN_IN,
        page: const SignIn(),
      ),
      RouteEntity(
        path: AppRoutesNames.REGISTER,
        page: const SignUp(),
      ),
      RouteEntity(
        path: AppRoutesNames.APPLICATION,
        page: const Application(),
      ),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      print("Clicked route is ${settings.name}");
    }
    if (settings.name != null) {
      var result = routes().where((elements) => elements.path == settings.name);

      if (result.isNotEmpty) {
        bool deviceFirstTime = Global.storageService.getDeviceFirstOpen();
        if (result.first.path == AppRoutesNames.WELCOME && deviceFirstTime) {
          bool isLoggedIn = Global.storageService.isLoggedIn();
          if(isLoggedIn){
             return MaterialPageRoute(
            builder: (_) => const Application(),
            settings: settings,
          );
          }else {
             return MaterialPageRoute(
            builder: (_) => const SignIn(),
            settings: settings,
          );
          }
         
        } else {
          if (kDebugMode) {
            print("App run first time");
          }
          return MaterialPageRoute(
            builder: (_) => result.first.page,
            settings: settings,
          );
        }
      }
    }
    return MaterialPageRoute(
      builder: (_) => const Welcome(),
      settings: settings,
    );
  }
}

class RouteEntity {
  String path;
  Widget page;
  RouteEntity({
    required this.path,
    required this.page,
  });
}
