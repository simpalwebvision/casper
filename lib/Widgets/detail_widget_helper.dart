import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailWidgetHelper extends StatelessWidget {
  final String heading, value;
  final Color? headingColor, valueColor;

  const DetailWidgetHelper({
    super.key,
    required this.heading,
    required this.value,
    this.headingColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: headingColor ?? blackColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          " :",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: blackColor),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.poppins(
                fontSize: 13.5,
                fontWeight: FontWeight.normal,
                color: valueColor ?? blackColor),
          ),
        ),
      ],
    );
  }
}

class MultiDetailHelper extends StatelessWidget {
  final String heading, value;
  final Color? valueColor, headingColor;

  const MultiDetailHelper(
      {super.key,
      required this.heading,
      required this.value,
      this.valueColor,
      this.headingColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: headingColor ?? blackColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          ":",
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: blackColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: valueColor ?? blackColor),
        ),
      ],
    );
  }
}

class RechargeWidget extends StatelessWidget {
  final String image, title, fromDate, toDate;
  final bool ispassEnded, isPassExpiring;
  final Color bgColor;
  const RechargeWidget({
    super.key,
    required this.fromDate,
    required this.image,
    required this.title,
    required this.toDate,
    required this.bgColor,
    required this.ispassEnded,
    required this.isPassExpiring,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ispassEnded || isPassExpiring ? Colors.red : bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: blackColor)),
      elevation: 3,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  image,
                  colorFilter: ColorFilter.mode(
                      ispassEnded || isPassExpiring ? whiteColor : blackColor,
                      BlendMode.srcIn),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    color:
                        ispassEnded || isPassExpiring ? whiteColor : blackColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  fromDate == "-" || fromDate == "No Present Recharge"
                      ? const SizedBox()
                      : Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.green,
                              size: 8,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                fromDate,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: ispassEnded || isPassExpiring
                                      ? whiteColor
                                      : blackColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  toDate == "-" || toDate == "No Present Recharge"
                      ? const SizedBox()
                      : Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: ispassEnded || isPassExpiring
                                  ? whiteColor
                                  : Colors.red,
                              size: 8,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                toDate,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: ispassEnded || isPassExpiring
                                      ? whiteColor
                                      : blackColor,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
