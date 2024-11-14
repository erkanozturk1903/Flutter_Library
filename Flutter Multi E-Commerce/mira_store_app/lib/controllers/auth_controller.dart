import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mira_store_app/global_variable.dart';
import 'package:mira_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mira_store_app/provider/user_provider.dart';
import 'package:mira_store_app/services/manage_http_response.dart';
import 'package:mira_store_app/views/screens/auth/login_screen.dart';
import 'package:mira_store_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signUpUsers({
    required BuildContext context,
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        password: password,
        locality: '',
        token: '',
      );
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
          showSnackBar(context, "Account has been created for you");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  //TODO: Sign in user function

  Future<void> signInUsers({
    required context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          //Access sharedPreferences for token and user data storage
          SharedPreferences preferences = await SharedPreferences.getInstance();

          //Extract the authentication token from the response body
          String token = jsonDecode(response.body)['token'];

          //Storage the authentication token securly in
          await preferences.setString('auth_token', token);

          //Encode the user data rec,ved from the backend as json
          final userJson = jsonEncode(jsonDecode(response.body)['user']);

          //update the application state with the user data using Riverpod
          providerContainer.read(userProvider.notifier).setUser(userJson);

          //store the data in sharePreference for future use
          await preferences.setString('user', userJson);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false);

          showSnackBar(context, "Login successfully ");
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  //Signout

  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //clear the token and user from SharedPreferences
      await preferences.remove('auth_token');
      await preferences.remove('user');
      //clear the user state
      providerContainer.read(userProvider.notifier).signOut();
      //navigate the user back to the logind screen
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return LoginScreen();
      }), (route) => false);

      showSnackBar(context, 'signout Successfully');
    } catch (e) {
      print(e);
    }
  }
}
