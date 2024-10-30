import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:flutter/material.dart';
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
          style: GoogleFonts.mukta(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: headingColor ?? blackColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          " :",
          style:
              GoogleFonts.mukta(fontWeight: FontWeight.bold, color: blackColor),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: GoogleFonts.mukta(
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
          style: GoogleFonts.mukta(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: headingColor ?? blackColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          ":",
          style:
              GoogleFonts.mukta(fontWeight: FontWeight.bold, color: blackColor),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: GoogleFonts.mukta(
              fontSize: 13,
              fontWeight: FontWeight.normal,
              color: valueColor ?? blackColor),
        ),
      ],
    );
  }
}
