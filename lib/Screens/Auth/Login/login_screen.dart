import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Utils/common_functions.dart';
import 'package:caspro_enterprises/Widgets/app_button.dart';
import 'package:caspro_enterprises/Widgets/app_helpers.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  DateTime now = DateTime.now();
  final controller = Get.put(LoginController());

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      AppImages.loginImage,
                      width: double.infinity,
                      height: Get.height * 0.38,
                    ),
                    Positioned(
                      child: Image.asset(
                        AppImages.appLogo,
                        height: Get.width * 0.2,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Login Yourself",
                          style: GoogleFonts.poppins(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Obx(
                          () => LoginTextField(
                            pref: const Icon(
                              CupertinoIcons.phone,
                              color: iconColor,
                            ),
                            controllerValue: controller.ctlMobile.value,
                            hintText: 'Mobile',
                            mLength: 10,
                            inputType: TextInputType.number,
                            validate: (val) {
                              if (val!.isEmpty) {
                                return "Cant be Empty.";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Obx(
                          () => controller.errorEmailText.value.isEmpty
                              ? Container()
                              : ErrorText(
                                  error: controller.errorEmailText.value,
                                  errorColor: Colors.red,
                                ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Obx(
                          () => LoginTextField(
                            pref: const Icon(
                              CupertinoIcons.lock,
                              color: iconColor,
                            ),
                            obsText: controller.showHidePass.value,
                            suf: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                    onTap: () =>
                                        controller.changeShowhidePass(),
                                    child: Icon(
                                      controller.showHidePass.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: iconColor,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () => controller.clearPass(),
                                    child: const Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: Icon(
                                        CupertinoIcons.clear_circled,
                                        color: iconColor,
                                      ),
                                    )),
                              ],
                            ),
                            controllerValue: controller.ctlPassword.value,
                            hintText: 'Password',
                            inputType: TextInputType.visiblePassword,
                            validate: (val) {
                              if (val!.isEmpty) {
                                return "Cant be Empty.";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Obx(
                          () => controller.errorPasswordText.value.isEmpty
                              ? Container()
                              : ErrorText(
                                  error: controller.errorPasswordText.value,
                                  errorColor: Colors.red,
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() => AppButton(
                            onPressed: controller.isLoggingIn.value
                                ? null
                                : () async {
                                    final isValid =
                                        _formKey.currentState!.validate();

                                    if (!isValid) {
                                      return;
                                    }
                                    _formKey.currentState!.save();
                                    CommonFunctions.hideKeyboard(context);
                                    // Get.bottomSheet(
                                    //     isScrollControlled: true,
                                    //     Container(
                                    //       padding: const EdgeInsets.symmetric(
                                    //           horizontal: 10, vertical: 10),
                                    //       width: double.infinity,
                                    //       color: whiteColor,
                                    //       child: Column(
                                    //         mainAxisSize: MainAxisSize.min,
                                    //         children: [
                                    //           SizedBox(
                                    //             width: double.infinity,
                                    //             child: ElevatedButton(
                                    //                 onPressed: () => Get
                                    //                     .offAllNamed(RouteNames
                                    //                         .superAdminHomeScreen),
                                    //                 child: Text(
                                    //                   "Super Admin",
                                    //                   style:
                                    //                       GoogleFonts.poppins(
                                    //                           color:
                                    //                               whiteColor),
                                    //                 )),
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 10,
                                    //           ),
                                    //           SizedBox(
                                    //             width: double.infinity,
                                    //             child: ElevatedButton(
                                    //                 onPressed: () => Get
                                    //                     .offAllNamed(RouteNames
                                    //                         .technicianHomeScreen),
                                    //                 child: Text(
                                    //                   "Technician",
                                    //                   style:
                                    //                       GoogleFonts.poppins(
                                    //                           color:
                                    //                               whiteColor),
                                    //                 )),
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 10,
                                    //           ),
                                    //           SizedBox(
                                    //             width: double.infinity,
                                    //             child: ElevatedButton(
                                    //                 onPressed: () => Get
                                    //                     .offAllNamed(RouteNames
                                    //                         .manufacturingUnitHomeScreen),
                                    //                 child: Text(
                                    //                   "Manufacturing Unit",
                                    //                   style:
                                    //                       GoogleFonts.poppins(
                                    //                           color:
                                    //                               whiteColor),
                                    //                 )),
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 10,
                                    //           ),
                                    //           SizedBox(
                                    //             width: double.infinity,
                                    //             child: ElevatedButton(
                                    //                 onPressed: () => Get
                                    //                     .offAllNamed(RouteNames
                                    //                         .customerHomeScreen),
                                    //                 child: Text(
                                    //                   "Customer",
                                    //                   style:
                                    //                       GoogleFonts.poppins(
                                    //                           color:
                                    //                               whiteColor),
                                    //                 )),
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ));

                                    controller.login();
                                  },
                            child: controller.isLoggingIn.value
                                ? const CommonButtonLoader(
                                    indicatorColor: primaryColor,
                                  )
                                : Text(
                                    "Sign In",
                                    style: GoogleFonts.poppins(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        // AppButton(
                        //     child: const Text(""),
                        //     onPressed: () {
                        //       controller.isLoggingIn(false);
                        //     }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Doesn't have an account yet ? ",
                //       style: GoogleFonts.poppins(color: Colors.black),
                //     ),
                //     InkWell(
                //       onTap: () => Get.toNamed(RouteNames.introOneScreen),
                //       child: Text(
                //         "Sign Up",
                //         style: GoogleFonts.poppins(
                //             color: primaryColor,
                //             fontWeight: FontWeight.bold,
                //             decoration: TextDecoration.underline),
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
