import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Widgets/columnimagehelper.dart';
import 'package:caspro_enterprises/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_shared_preferences.dart';
import 'routes_names.dart';

class CommonFunctions {
  final picker = ImagePicker();
  static var globalContext = NavigationService.navigatorKey.currentContext!;
  static void hideKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  // launchURL(url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // // Function to launch phone dialer
  // void launchPhoneDialer(String phoneNumber) async {
  //   final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  //   if (await canLaunchUrl(phoneUri)) {
  //     await launchUrl(phoneUri);
  //   } else {
  //     throw 'Could not launch $phoneNumber';
  //   }
  // }

  // Function to launch email client
  // void launchEmail(String emailAddress) async {
  //   final Uri emailUri = Uri(
  //     scheme: 'mailto',
  //     path: emailAddress,
  //     // queryParameters: {
  //     //   'subject': 'Example Subject',
  //     //   'body': 'Hello, this is a test email.',
  //     // },
  //   );
  //   if (await canLaunchUrl(emailUri)) {
  //     await launchUrl(emailUri);
  //   } else {
  //     throw 'Could not launch $emailAddress';
  //   }
  // }

  String returnAppDateFormat(DateTime date) =>
      DateFormat('dd-MM-yyyy').format(date);

  String returnApiDateFormat(DateTime date) =>
      DateFormat('yyyy-MM-dd').format(date);

  static String returnCreatedAtFormat() =>
      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  String convertToApplicationShowDate(String date) {
    if (date.isEmpty) {
      return "";
    }
    var helper = date.split("-");

    return "${helper[2]}-${helper[1]}-${helper[0]}";
  }

  // Future<UserProfileModel> getUserProfileData() async {
  //   String helper = await LocalPreferences().getUserProfileData() ?? "";

  //   return UserProfileModel.fromJson(jsonDecode(helper));
  // }

  // Future<ServiceMemberModel> getStaffProfileData() async {
  //   String helper = await LocalPreferences().getStaffProfileData() ?? "";

  //   return ServiceMemberModel.fromJson(jsonDecode(helper));
  // }

  static showGetxSnackBar(String title,
      {String? msg, SnackPosition? position, Color? backColor, int? durSec}) {
    Get.snackbar("", "",
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        titleText: Text(
          title,
          style: GoogleFonts.poppins(
              color: whiteColor, fontWeight: FontWeight.bold),
        ),
        messageText: msg == null
            ? null
            : Text(
                msg,
                style: GoogleFonts.poppins(color: whiteColor),
              ),
        snackPosition: position ?? SnackPosition.BOTTOM,
        backgroundColor: backColor ?? Colors.red,
        duration: Duration(seconds: durSec ?? 3));
  }

  stateCityAreaDialogue(
      {required BuildContext context,
      required String title,
      required TextEditingController controller,
      required Function(String)? onChange,
      required listWidget}) {
    return Get.dialog(
      GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          color: whiteColor,
          child: SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.arrow_back_ios)),
                    Expanded(
                      child: Text(title,
                          style: GoogleFonts.poppins(
                              color: blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    const Icon(
                      CupertinoIcons.location_solid,
                      color: primaryColor,
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  autofocus: true,
                  style: GoogleFonts.poppins(fontSize: 14),
                  maxLength: 15,
                  onChanged: onChange,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required*';
                    } else {
                      return null;
                    }
                  },
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        CupertinoIcons.search,
                        size: 12,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: blackColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: blackColor)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: blackColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.red)),
                      hintText: title,
                      helperStyle: GoogleFonts.poppins(fontSize: 14),
                      counterText: ""),
                ),
                const SizedBox(
                  height: 5,
                ),
                listWidget
              ],
            ),
          ),
        ),
      ),
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  showPopUp({
    required BuildContext context,
    required double screenHeight,
    required double screenWidth,
    required VoidCallback onCameraClick,
    required VoidCallback onGalleryClick,
  }) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Wrap(children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select By',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ColumnImageTextHelper(
                          imagePath: AppImages.bycamera,
                          title: 'Camera',
                          onCLicked: onCameraClick,
                          sHeight: screenHeight,
                        )),
                        const SizedBox(
                            height: 30,
                            child: VerticalDivider(color: Colors.black)),
                        Expanded(
                          child: ColumnImageTextHelper(
                            imagePath: AppImages.bygallery,
                            title: 'Gallery',
                            onCLicked: onGalleryClick,
                            sHeight: screenHeight,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]);
        });
  }

  Future<dynamic> pickAndCropImage({required String from}) async {
    final picker = ImagePicker();
    final XFile? pickedFile;
    if (from == "camera") {
      pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    } else {
      pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    }

    if (pickedFile != null) {
      // Crop the picked image
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: primaryColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              aspectRatioPresets: [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9,
              ],
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ],
          ),
        ],
      );

      if (croppedFile != null) {
        // Do something with the cropped image (e.g., display it or upload it)

        return croppedFile;
      } else {
        return null;
      }
    }
  }

  void logOut() async {
    LocalPreferences().setLoginBool(false);
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.offAllNamed(RouteNames.splashScreen);
  }
}
