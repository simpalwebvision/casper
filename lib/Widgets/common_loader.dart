import 'package:flutter/material.dart';

import '../Utils/app_constants.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 4.5,
      strokeCap: StrokeCap.round,
      strokeAlign: BorderSide.strokeAlignInside,
      backgroundColor: primaryColor,
      valueColor: AlwaysStoppedAnimation(secondaryColor),
    );
  }
}
