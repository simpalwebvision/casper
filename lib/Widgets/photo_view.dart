import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewScreen extends StatelessWidget {
  const PhotoViewScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    String image = arguments['image'] as String;
    String title = arguments['title'] as String;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: commonAppBar(context: context, heading: title),
      body: Center(
        child: Container(
          color: whiteColor,
          // Adjust the width and height according to your preference
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: PhotoView(
            imageProvider: NetworkImage(image), // Replace with your image URL
          ),
        ),
      ),
    );
  }
}
