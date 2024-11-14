import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mira_store_app/provider/user_provider.dart';
import 'package:mira_store_app/views/screens/auth/login_screen.dart';
import 'package:mira_store_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  Future<void> _checkTokenAndSetUser(ref) async {
    //ontain an instance of sharedPreferences for local  data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //Retrive the authentication token and user data stored locally
    String? token = preferences.getString('auth_token');
    String? userJson = preferences.getString('user');

    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).signOut();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = ref.watch(userProvider);
          return user != null ? const MainScreen() : LoginScreen();
        },
      ),
    );
  }
}
