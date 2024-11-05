// sign_up_controller.dart
// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mira_academy/common/global_loader/global_loader.dart';
import 'package:mira_academy/common/widgets/popup_messages.dart';
import 'package:mira_academy/pages/sign_up/notifier/register_notifier.dart';

class SignUpController {
  final WidgetRef ref;
  BuildContext get context => ref.context;

  SignUpController({required this.ref});

  Future<void> handleSignUp() async {
    var state = ref.read(registerNotifierProvider);
    
    
    // Form validation
    if (!_validateForm(state)) return;

    // Show loading
    ref.read(appLoaderProvider.notifier).setLoaderValue(true);
    
    try {
      await _createUserAccount(state);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      ref.watch(appLoaderProvider.notifier).setLoaderValue(false);
    }
  }

  bool _validateForm(dynamic state) {
    if (state.userName.isEmpty) {
      ToastHelper.toastInfo(context, "Your name is empty");
      return false;
    }

    if (state.userName.length < 6) {
      ToastHelper.toastInfo(context, "Your name is too short");
      return false;
    }

    if (state.email.isEmpty) {
      ToastHelper.toastInfo(context, "Your email is empty");
      return false;
    }

    if (state.password.isEmpty || state.rePassword.isEmpty) {
      ToastHelper.toastInfo(context, "Your password is empty");
      return false;
    }

    return true;
  }

  Future<void> _createUserAccount(dynamic state) async {
    var navContext = Navigator.of(context);
    
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );

    if (kDebugMode) {
      print(credential);
    }

    if (credential.user != null) {
      await credential.user?.sendEmailVerification();
      await credential.user?.updateDisplayName(state.userName);
      
      ToastHelper.toastInfo(
        context,
        "An email has been sent to verify your account. Please open that email and confirm your identity"
      );
      
      navContext.pop();
    }
  }
}