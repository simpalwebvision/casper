import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadImageList extends StatefulWidget {
  const UploadImageList({super.key});

  @override
  State<UploadImageList> createState() => _UploadImageListState();
}

class _UploadImageListState extends State<UploadImageList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Image List"),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () {},
        label: Row(
          children: [
            const Icon(
              Icons.add_a_photo,
              color: whiteColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Upload Image',
              style: GoogleFonts.poppins(color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
