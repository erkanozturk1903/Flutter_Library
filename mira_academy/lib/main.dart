import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mira_academy/common/utils/app_styles.dart';
import 'package:mira_academy/global.dart';
import 'package:mira_academy/pages/application/application.dart';
import 'package:mira_academy/pages/sign_in/sign_in.dart';
import 'package:mira_academy/pages/sign_up/sign_up.dart';
import 'package:mira_academy/pages/welcome/welcome.dart';

Future<void> main() async {
  Global.init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

var routesMap = {
  "/": (context) => const Welcome(),
  "/sign_in": (context) => const SignIn(),
  "/register": (context) => const SignUp(),
  "/application": (context) => const Application(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.appThemeData,
        initialRoute: "/",
        routes: routesMap,
        onGenerateRoute: (settings) {
          
        },
        //home: const Welcome(), // initial Route
      ),
    );
  }
}
