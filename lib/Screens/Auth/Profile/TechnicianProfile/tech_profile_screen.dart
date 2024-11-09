import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/app_helpers.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:caspro_enterprises/Widgets/upload_images_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nb_utils/nb_utils.dart' as nb;

import 'tech_profile_controller.dart';

class TechProfileScreen extends StatefulWidget {
  const TechProfileScreen({super.key});

  @override
  State<TechProfileScreen> createState() => _TechProfileScreenState();
}

class _TechProfileScreenState extends State<TechProfileScreen> {
  final controller = Get.put(TechProfileController());
  bool colorChange = false;
  CroppedFile? document;
  @override
  void initState() {
    nb.setStatusBarColor(primaryColor);
    super.initState();
  }

  @override
  void dispose() {
    nb.setStatusBarColor(whiteColor);
    Get.delete<TechProfileController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: commonAppBar(context: context, heading: "Profile"),
        body: colorChange
            ? const SizedBox()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    UploadImagesHelperProfile(
                      uploadImage: () {
                        CommonFunctions().showPopUp(
                            context: context,
                            screenHeight: size.height,
                            screenWidth: size.width,
                            onCameraClick: () async {
                              Navigator.pop(context);
                              setState(() {
                                colorChange = true;
                              });
                              await CommonFunctions()
                                  .pickAndCropImage(from: "camera")
                                  .then((value) {
                                setState(() {
                                  colorChange = false;

                                  if (value != null) {
                                    document = value;
                                  }
                                });
                              });
                            },
                            onGalleryClick: () async {
                              Navigator.pop(context);
                              setState(() {
                                colorChange = true;
                              });
                              await CommonFunctions()
                                  .pickAndCropImage(from: "gallery")
                                  .then((value) {
                                setState(() {
                                  colorChange = false;

                                  if (value != null) {
                                    document = value;
                                  }
                                });
                              });
                            });
                      },
                      removeImage: () {
                        document = null;
                        setState(() {});
                      },
                      passedfile: document,
                      // imagePath: controller.userProfileModel.value == null
                      //     ? ""
                      //     : controller.userProfileModel.value!.image
                      imagePath: "",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Obx(
                      () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor),
                          onPressed: controller.btnIsLoading.value
                              ? null
                              : () {
                                  if (document == null) {
                                    CommonFunctions.showGetxSnackBar("Error",
                                        msg: "Select Image for update.");
                                  } else {}
                                },
                          child: controller.btnIsLoading.value
                              ? const CommonButtonLoader(
                                  indicatorColor: whiteColor)
                              : Text(
                                  'Update',
                                  style: GoogleFonts.poppins(color: whiteColor),
                                )),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            StepperTextField(
                              rOnly: true,
                              controllerValue: controller.ctlName.value,
                              inputType: TextInputType.text,
                              validate: (val) {
                                if (val!.isEmpty) {
                                  return "Username can't be empty.";
                                } else {
                                  return null;
                                }
                              },
                              hintValue: "Username",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            StepperTextField(
                              mLength: 10,
                              rOnly: true,
                              controllerValue: controller.ctlMobile.value,
                              inputType: TextInputType.phone,
                              validate: (val) {
                                return null;
                              },
                              hintValue: "Mobile",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            StepperTextField(
                              rOnly: true,
                              controllerValue: controller.ctlEmail.value,
                              inputType: TextInputType.emailAddress,
                              validate: (val) {
                                return null;
                              },
                              hintValue: "Email",
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            StepperTextField(
                              rOnly: true,
                              controllerValue: controller.ctlAddress.value,
                              inputType: TextInputType.streetAddress,
                              validate: (val) {
                                return null;
                              },
                              hintValue: "Address",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: primaryColor,
          onPressed: () => CommonFunctions().logOut(),
          label: Row(
            children: [
              const Icon(
                Icons.logout,
                color: whiteColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'logout',
                style: GoogleFonts.poppins(color: whiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
