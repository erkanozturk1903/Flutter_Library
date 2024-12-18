import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mira_academy/common/routes/app_routes_names.dart';
import 'package:mira_academy/features/application/view/application.dart';
import 'package:mira_academy/features/sign_in/view/sign_in.dart';
import 'package:mira_academy/features/sign_up/view/sign_up.dart';
import 'package:mira_academy/features/welcome/view/welcome.dart';

import '../../features/home/view/home.dart';
import '../../global.dart';

class AppPages {
  static List<RouteEntity> routes() {
    return [
      RouteEntity(path:AppRoutesNames.WELCOME, page:Welcome()),
      RouteEntity(path: AppRoutesNames.SIGN_IN, page: const SignIn()),
      RouteEntity(path: AppRoutesNames.REGISTER, page: const SignUp()),
      RouteEntity(path: AppRoutesNames.APPLICATION, page: const Application()),
      RouteEntity(path: AppRoutesNames.HOME, page: const Home()),
    ];
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (kDebugMode) {
      //print("clicked route is ${settings.name}");
    }
    if(settings.name!=null){

      var result = routes().where((element) => element.path==settings.name);

      if(result.isNotEmpty){
        //if we used this is first time  or not
        bool deviceFirstTime= Global.storageService.getDeviceFirstOpen();

        if(result.first.path==AppRoutesNames.WELCOME&&deviceFirstTime){

          bool isLoggedIn = Global.storageService.isLoggedIn();
          if(isLoggedIn){
            return MaterialPageRoute(
                builder: (_) => const Application(),
                settings: settings);
          }else{
            return MaterialPageRoute(
                builder: (_) => const SignIn(),
                settings: settings);
          }

        }else{
          if (kDebugMode) {
           // print('App ran first time');
          }
          return MaterialPageRoute(
              builder: (_) => result.first.page,
              settings: settings);
        }
      }
    }
    return MaterialPageRoute(
        builder: (_) => Welcome(),
        settings: settings);
  }
}

class RouteEntity{
  String path;
  Widget page;
  RouteEntity({required this.path, required this.page});
}
