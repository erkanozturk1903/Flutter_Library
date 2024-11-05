import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mira_academy/common/utils/app_colors.dart';
import 'package:mira_academy/common/widgets/app_bar.dart';
import 'package:mira_academy/common/widgets/app_shadow.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: buildAppbar(title: "Home Page"),
          body: Container(),
          bottomNavigationBar: Container(
            width: 375.w,
            height: 58.h,
            decoration: appBoxShadowWithRadius(),
            child: BottomNavigationBar(
              elevation: 0,
              items: [],
            ),
          ),
        ),
      ),
    );
  }
}
