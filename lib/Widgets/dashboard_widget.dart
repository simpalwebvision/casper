import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
