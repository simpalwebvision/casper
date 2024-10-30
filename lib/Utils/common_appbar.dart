import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar commonAppBar(
    {required BuildContext context,
    required String heading,
    String? subtitle,
    double? elv = 0,
    PreferredSizeWidget? bottom,
    List<Widget>? widgetList,
    VoidCallback? onPressed,
    bool? centerTitle}) {
  return AppBar(
    backgroundColor: secondaryColor,
    elevation: elv,
    centerTitle: centerTitle,
    title: Text(
      heading,
      style: GoogleFonts.poppins(
        color: whiteColor,
        fontSize: 15,
      ),
    ),
    iconTheme: const IconThemeData(color: blackColor),
    actions: widgetList,
    bottom: bottom,
    leading: InkWell(
        onTap: onPressed ??
            () {
              Navigator.pop(context);
            },
        child: Container(
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: whiteColor, borderRadius: BorderRadius.circular(8)),
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 15,
              color: blackColor,
            ))),
  );
}
