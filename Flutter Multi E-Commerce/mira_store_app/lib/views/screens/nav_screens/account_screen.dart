import 'package:flutter/material.dart';
import 'package:mira_store_app/controllers/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  final AuthController _authController = AuthController();
  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () async {
            await _authController.signOutUser(context: context);
          },
          child: const Text('Sign Out')),
    );
  }
}
