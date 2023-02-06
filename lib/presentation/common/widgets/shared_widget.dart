import 'package:flutter/material.dart';

import '../../resources/values_manager.dart';

Widget getSection(String title ,BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(
        left: AppPadding.p12,
        right: AppPadding.p12,
        top: AppPadding.p12,
        bottom: AppPadding.p12),
    child: Text(
      title,
      style: Theme.of(context).textTheme.labelSmall,
    ),
  );
}