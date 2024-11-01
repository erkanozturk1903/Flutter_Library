import 'package:flutter/material.dart';
import 'package:mira_academy/common/utils/app_colors.dart';
import 'package:mira_academy/common/widgets/text_widgets.dart';

AppBar buildAppbar({String title=""}) {
  return AppBar(

    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        color: Colors.grey.withOpacity(0.3),
        height: 1,
      ),
    ),
    title: text16Normal(text: title, color: AppColors.primaryText),
  );
}
