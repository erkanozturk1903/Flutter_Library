// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mira_academy/common/widgets/app_bar.dart';
import 'package:mira_academy/common/widgets/app_textfields.dart';
import 'package:mira_academy/common/widgets/button_widgets.dart';
import 'package:mira_academy/common/widgets/text_widgets.dart';

import 'widgets/sign_in_widgets.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            appBar: buildAppbar(title: "Login"),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //top login buttons
                  thirdPartyLogin(),
                  //more login options message
                  Center(
                      child: text14Normal(
                          text: "Or use your email account to login")),
                  SizedBox(
                    height: 50.h,
                  ),
                  //email text box
                  appTextField(
                      text: "Email",
                      iconName: "assets/icons/user.png",
                      hintText: "Enter your email address",),
                  SizedBox(
                    height: 20.h,
                  ),
                  //password text box
                  appTextField(
                      text: "Password",
                      iconName: "assets/icons/lock.png",
                      hintText: "Enter your password",
                      obscureText: true),
                  SizedBox(
                    height: 20.h,
                  ),
                  //forgot text
                  Container(
                      margin: EdgeInsets.only(left: 25.w),
                      child: textUnderline(text: "Forgot password?")),
                  SizedBox(
                    height: 100.h,
                  ),
                  //app login button
                  Center(child: appButton(buttonName: "Login")),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                      child: appButton(
                          buttonName: "Register",
                          isLogin: false,
                          context: context,
                          func: ()=>Navigator.pushNamed(context, "/register")))
                  //app register button
                ],
              ),
            )),
      ),
    );
  }
}
