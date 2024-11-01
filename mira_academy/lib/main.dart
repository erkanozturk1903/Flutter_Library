import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mira_academy/common/utils/app_styles.dart';
import 'package:mira_academy/firebase_options.dart';
import 'package:mira_academy/pages/sign_in/sign_in.dart';
import 'package:mira_academy/pages/sign_up/sign_up.dart';
import 'package:mira_academy/pages/welcome/welcome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

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
        routes: {
          "/": (context) => const Welcome(),
          "/signIn": (context) => const SignIn(),
          "/register": (context) => const SignUp(),
        },
        //home: const Welcome(), // initial Route
      ),
    );
  }
}
