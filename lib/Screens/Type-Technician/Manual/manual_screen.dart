import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/common_loader.dart';
import 'package:caspro_enterprises/Widgets/custom_image.dart';
import 'package:caspro_enterprises/Widgets/upload_images_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';

import 'manual_screen_controller.dart';

class ManualScreen extends StatefulWidget {
  const ManualScreen({super.key});

  @override
  State<ManualScreen> createState() => _ManualScreenState();
}

class _ManualScreenState extends State<ManualScreen> {
  var controller = Get.put(ManualsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Tech Manuals"),
      body: DefaultTabController(
        initialIndex: controller.initialIndex.value,
        length: 2,
        child: Builder(builder: (context) {
          return Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  onTap: (value) => controller.onChangeTab(context, value),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  tabAlignment: TabAlignment.start,
                  isScrollable: true,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  dividerColor: Colors.transparent,
                  controller: DefaultTabController.of(context),
                  labelColor: Colors.black,
                  indicatorColor: primaryColor,
                  tabs: [
                    Tab(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.imagesStore,
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "IMAGES",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppImages.filesStore,
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "FILES",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () => controller.getManuals(),
                child: Obx(() => controller.isLoading.value
                    ? const CommonLoader()
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 10,
                            ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        itemBuilder: (context, index) {
                          var data = controller.initialIndex.value == 0
                              ? controller.imageList[index]
                              : controller.fileList[index];
                          return controller.initialIndex.value == 0
                              ? InkWell(
                                  // onTap: () => Get.toNamed(
                                  //     RouteNames.photoViewer,
                                  //     arguments: {
                                  //       "image": data.urlLink ?? "",
                                  //       "title": data.fileName ?? ""
                                  //     }),
                                  child: Card(
                                    shadowColor: blackColor,
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1.5, color: primaryColor),
                                        borderRadius: BorderRadius.circular(8)),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            child: CustomImage(
                                                image: data.urlLink ?? "",
                                                errorImage:
                                                    AppImages.noImageError,
                                                imgHeight: 40,
                                                imgWidth: 40),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: Text(
                                            data.fileName ?? "",
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                                fontSize: 13),
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () async {
                                    // await EasyLoading.show(
                                    //   status: 'Loading PDF Contents',
                                    //   maskType: EasyLoadingMaskType.black,
                                    // );
                                    // try {
                                    //   final file = await PdfApi.loadNetworkFile(
                                    //       data.urlLink);
                                    //   EasyLoading.dismiss();
                                    //   Get.toNamed(RouteNames.pdfViewerPageTwo,
                                    //       arguments: {
                                    //         "file": file,
                                    //         "file_name": data.fileName
                                    //       });
                                    // } catch (error) {
                                    //   EasyLoading.dismiss();
                                    //   CommonFunctions.showErrorSnackbar(
                                    //       "Network Error..");
                                    // }
                                  },
                                  child: Card(
                                    shadowColor: blackColor,
                                    clipBehavior: Clip.hardEdge,
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1.5, color: primaryColor),
                                        borderRadius: BorderRadius.circular(8)),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.pdfImage,
                                            height: 40,
                                            width: 40,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                              child: Text(
                                            data.fileName ?? "",
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                                fontSize: 13),
                                          ))
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        itemCount: controller.initialIndex.value == 0
                            ? controller.imageList.length
                            : controller.fileList.length)),
              ))
            ],
          );
        }),
      ),
      // floatingActionButton: CustomSpeedDial(
      //   onFirstClick: () {
      //     controller.toggleOpenClose();
      //     showCustomDialog("image");
      //   },
      //   onSecondClick: () {
      //     controller.toggleOpenClose();
      //     showCustomDialog("text");
      //   },
      // ),
    );
  }

  void showCustomDialog(String type) {
    Get.dialog(
      AlertDialog(
        icon: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: blackColor),
                    color: whiteColor,
                  ),
                  child: const Icon(Icons.close)),
            )),
        titleTextStyle: GoogleFonts.poppins(
            color: blackColor, fontWeight: FontWeight.bold, fontSize: 20),
        title: Text(
          type == "image"
              ? "Upload Image"
              : type == "text"
                  ? "Upload Text"
                  : "Upload File",
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const UploadImageDialogue(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Upload",
                style: GoogleFonts.poppins(color: whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UploadImageDialogue extends StatefulWidget {
  const UploadImageDialogue({super.key});

  @override
  State<UploadImageDialogue> createState() => _UploadImageDialogueState();
}

class _UploadImageDialogueState extends State<UploadImageDialogue> {
  CroppedFile? document;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return UploadBusinessHelper(
      title: "+ Select File",
      uploadImage: () {
        CommonFunctions().showPopUp(
            context: context,
            screenHeight: size.height,
            screenWidth: size.width,
            onCameraClick: () async {
              Navigator.pop(context);

              await CommonFunctions()
                  .pickAndCropImage(from: "camera")
                  .then((value) {
                setState(() {
                  if (value != null) {
                    document = value;
                  }
                });
              });
            },
            onGalleryClick: () async {
              Navigator.pop(context);

              await CommonFunctions()
                  .pickAndCropImage(from: "gallery")
                  .then((value) {
                setState(() {
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
    );
  }
}
