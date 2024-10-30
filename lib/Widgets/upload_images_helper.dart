import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shimmer/shimmer.dart';

class UploadImagesHelper extends StatelessWidget {
  final String? imagePath;

  final VoidCallback uploadImage, removeImage;
  final CroppedFile? passedfile;
  const UploadImagesHelper(
      {super.key,
      required this.uploadImage,
      required this.removeImage,
      this.passedfile,
      this.imagePath = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        passedfile == null
            ? imagePath != ""
                ? Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: primaryColor)),
                        height: 150,
                        width: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: CachedNetworkImage(
                              imageUrl: imagePath!,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor: Colors.white,
                                          enabled: true,
                                          child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                                color: Colors.white70,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                        ),
                                      ),
                              errorWidget: (context, url, error) => Container(
                                  color: primaryColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Add\nLogo',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ),
                      InkWell(
                          onTap: uploadImage,
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Text(
                              'Upload',
                              style: GoogleFonts.nunito(color: Colors.white),
                            ),
                          )),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: uploadImage,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: blackColor,
                            ),
                            borderRadius: BorderRadius.circular(15)),
                        height: 140,
                        width: 150,
                        child: Text(
                          '+ Upload',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold, color: blackColor),
                        ),
                      ),
                    ),
                  )
            : Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: InkWell(
                        onTap: uploadImage,
                        child: Image.file(
                          File(passedfile!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                        onTap: removeImage,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: const Icon(
                            Icons.close,
                            color: whiteColor,
                          ),
                        )),
                  ),
                ],
              )
      ],
    );
  }
}

class UploadImagesHelperProfile extends StatelessWidget {
  final String? imagePath;

  final VoidCallback uploadImage, removeImage;
  final CroppedFile? passedfile;
  const UploadImagesHelperProfile(
      {super.key,
      required this.uploadImage,
      required this.removeImage,
      this.passedfile,
      this.imagePath = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        passedfile == null
            ? imagePath != ""
                ? Column(
                    children: [
                      InkWell(
                        onTap: uploadImage,
                        child: Container(
                          margin: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: blackColor)),
                          height: 150,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: imagePath!,
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor: Colors.white,
                                        enabled: true,
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      ),
                                    ),
                                errorWidget: (context, url, error) => Container(
                                    color: primaryColor,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Add\nProfile',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.nunito(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ),
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: InkWell(
                      onTap: uploadImage,
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: blackColor,
                            ),
                            borderRadius: BorderRadius.circular(100)),
                        height: 140,
                        width: 150,
                        child: Text(
                          '+ Upload',
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold, color: blackColor),
                        ),
                      ),
                    ),
                  )
            : Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    height: 150,
                    width: 150,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: InkWell(
                        onTap: uploadImage,
                        child: Image.file(
                          File(passedfile!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: 20,
                    child: InkWell(
                        onTap: removeImage,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: const Icon(
                            Icons.close,
                            color: whiteColor,
                          ),
                        )),
                  ),
                ],
              )
      ],
    );
  }
}

class UploadBusinessHelper extends StatelessWidget {
  final String? title;
  final VoidCallback uploadImage, removeImage;
  final CroppedFile? passedfile;
  const UploadBusinessHelper({
    super.key,
    required this.uploadImage,
    required this.removeImage,
    this.passedfile,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        passedfile == null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: InkWell(
                  onTap: uploadImage,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: blackColor,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    height: size.width * 0.6,
                    width: size.width * 0.8,
                    child: Text(
                      title ?? '+ Upload Customer Business Card',
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold, color: blackColor),
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: size.width * 0.6,
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: uploadImage,
                        child: Image.file(
                          File(passedfile!.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: InkWell(
                        onTap: removeImage,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: const Icon(
                            Icons.close,
                            color: whiteColor,
                          ),
                        )),
                  ),
                ],
              )
      ],
    );
  }
}
