import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const primaryColor = Color(0xFFdf1b25);
const secondaryColor = Color(0xFF29378f);
const accentColor = Color(0xFFFFEB3B);
const blackColor = Color(0xFF212427);
const whiteColor = Color(0xFFFFFFFF);
const borderColor = Color(0xFFD6D6D6);
const headingColor = Color(0xFF002856);
const lightGrayColor = Color(0xFFF8F9FA);
Color greyColor = const Color(0xFFEEEEEE);
Color planColor = const Color(0xFFf8efd7);
Color totalContactColor = const Color(0xFFe9f9f7);
Color successColor = Colors.green;
Color failedColor = Colors.red;
Color blueColor = const Color(0xFF278ce4);
Color transparentColor = Colors.transparent;

Color purpleColor = const Color(0xFF9290ff);
Color greenColor = const Color(0xFF60c879);
const Color backGroundColor = Color.fromARGB(255, 247, 247, 247);
const iconColor = Color(0xFF5a585b);
const darkBlueColor = Color(0xFF2f415d);
Color grey200 = const Color(0xFFEEEEEE);

Card settingsCommonCard({required Widget child}) {
  return Card(
    margin: EdgeInsets.zero,
    elevation: 0,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: borderColor)),
    child: child,
  );
}

Text settingsTitle(String title) {
  return Text(
    title,
    style: GoogleFonts.poppins(
      color: blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 13,
    ),
  );
}

double toFixed(num val) {
  num mod = power(10, 2);
  return (((val * mod)).floor().toDouble() / mod);
}

int power(int x, int n) {
  int retval = 1;
  for (int i = 0; i < n; i++) {
    retval *= x;
  }
  return retval;
}

String checkNullOperatorFun(dynamic val) {
  if (val == null) {
    return "";
  } else if (val.isEmpty) {
    return "-";
  } else {
    return val;
  }
}
