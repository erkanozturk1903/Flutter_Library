// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mira_academy/pages/welcome/widgets.dart';

final indexProvider = StateProvider<int>((ref) => 0);

class Welcome extends ConsumerWidget {
  Welcome({super.key});

  final PageController _controller = PageController();
  int dotsIndex = 0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexProvider);
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: EdgeInsets.only(top: 30.h),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  onPageChanged: (value) {
                    dotsIndex = value;
                    ref.read(indexProvider.notifier).state = value;
                  },
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                    //first page
                    appOnboardingPage(
                      _controller,
                      imagePath: "assets/images/reading.png",
                      title: "First See Learning",
                      subTitle:
                          "Forget about the paper, now learning all in one place",
                      index: 1,
                    ),
                    //second page
                    appOnboardingPage(
                      _controller,
                      imagePath: "assets/images/man.png",
                      title: "Connect With Everyone",
                      subTitle:
                          "Always keep in touch with your tutor and friends. Let's get connected",
                      index: 2,
                    ),
                    appOnboardingPage(
                      _controller,
                      imagePath: "assets/images/boy.png",
                      title: "Always Facinated Learning",
                      subTitle:
                          "Anywhere, anytime. The time is at your discretion. So study wherever you can",
                      index: 3,
                    )
                  ],
                ),
                Positioned(
                  bottom: 50,
                  child: DotsIndicator(
                    position: dotsIndex,
                    dotsCount: 3,
                    mainAxisAlignment: MainAxisAlignment.center,
                    decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(24.0, 8.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.w))),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
