import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportDataWidget extends StatelessWidget {
  final Color bgColor;
  final num value;
  final String title;
  const ReportDataWidget(
      {super.key,
      required this.bgColor,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.zero,
      color: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: blackColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500, fontSize: 13),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\u{20B9}",
                  style: GoogleFonts.poppins(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                AnimatedFlipCounter(
                  duration: const Duration(milliseconds: 500),
                  value: toFixed(value),
                  textStyle: GoogleFonts.poppins(
                      color: blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  fractionDigits: 2,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  final String widgetText, imageAssets;
  final VoidCallback? onClicked;

  const DashboardWidget({
    super.key,
    required this.widgetText,
    required this.imageAssets,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.grey, width: 1),
        ),
        shadowColor: Colors.grey.withOpacity(0.3),
        elevation: 5.0,
        child: InkWell(
          onTap: onClicked,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imageAssets,
                height: size.height * 0.06,
                width: size.width * 0.05,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widgetText,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TechnicianDashBoardWidget extends StatelessWidget {
  final String title, iconString;
  final VoidCallback onPressed;

  const TechnicianDashBoardWidget(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.iconString});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: blackColor)),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(iconString,
                  height: AppImages.complaints == iconString ? 40 : 35,
                  width: AppImages.complaints == iconString ? 40 : 35,
                  colorFilter:
                      const ColorFilter.mode(secondaryColor, BlendMode.srcIn)),
              // ),
              SizedBox(
                height: AppImages.complaints == iconString ? 10 : 15,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    color: blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
