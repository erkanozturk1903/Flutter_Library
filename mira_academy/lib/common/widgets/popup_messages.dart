// toast_helper.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static FToast? _fToast;

  static void toastInfo(
    BuildContext context,
    String msg, {
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
  }) {
    _fToast ??= FToast();
    _fToast!.init(context);
    _fToast!.removeQueuedCustomToasts();

    Widget toast = Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        color: backgroundColor,
      ),
      child: Text(
        msg,
        style: TextStyle(
          color: textColor,
          fontSize: 16.sp,
        ),
      ),
    );

    _fToast!.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}