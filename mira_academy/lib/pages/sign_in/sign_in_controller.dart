// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mira_academy/common/entities/user.dart';
import 'package:mira_academy/common/global_loader/global_loader.dart';
import 'package:mira_academy/common/utils/constants.dart';
import 'package:mira_academy/common/widgets/popup_messages.dart';
import 'package:mira_academy/global.dart';
import 'package:mira_academy/pages/application/application.dart';
import 'package:mira_academy/pages/sign_in/notifier/sign_in_notifier.dart';

class SignInController {
  WidgetRef ref;
  BuildContext get context => ref.context;

  SignInController(
    this.ref,
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void handleSignIn() async {
    var state = ref.read(signInNotifierProvider);
    String email = state.email;
    String password = state.password;
    emailController.text = email;
    passwordController.text = password;

    if (state.email.isEmpty || email.isEmpty) {
      ToastHelper.toastInfo(context, "Your email is empty");
      return;
    }

    if (state.password.isEmpty || password.isEmpty) {
      ToastHelper.toastInfo(context, "Your password is empty");
      return;
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        ToastHelper.toastInfo(context, "User not found");
      }
      if (!credential.user!.emailVerified) {
        ToastHelper.toastInfo(
          context,
          "You must veriyf your email address first!",
        );
      }
      var user = credential.user;
      if (user != null) {
        String? displayName = user.displayName;
        String? email = user.email;
        String? id = user.uid;
        String? photoUrl = user.photoURL;
        //String? phoneNumber = user.phoneNumber;

        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.name = displayName;
        loginRequestEntity.email = email;
        loginRequestEntity.open_id = id;
        loginRequestEntity.type = 1;
        asyncPostAllData(loginRequestEntity);
        print('user logged in');
      } else {
        ToastHelper.toastInfo(context, "Login Error");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ToastHelper.toastInfo(context, "User not found");
      } else if (e.code == 'wrong-password') {
        ToastHelper.toastInfo(context, "Your password is wrong");
      }
      print(e.code);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    ref.read(appLoaderProvider.notifier).setLoaderValue(false);
  }

  void asyncPostAllData(LoginRequestEntity loginRequestEntity) {
    //we need to talk to server

    // have local storage
    try {
      var navigator = Navigator.of(ref.context);
      Global.storageService.setString(
        AppConstants.STORAGE_USER_PROFILE_KEY,
        "123",
      );
      Global.storageService.setString(
        AppConstants.STORAGE_USER_TOKEN_KEY,
        "123456",
      );
      navigator.pushNamedAndRemoveUntil("/application", (route) => false);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    // redirect to new page
  }
}
