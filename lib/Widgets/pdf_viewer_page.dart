import 'dart:io';

import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/common_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'common_loader.dart';

class PFDViewerPage extends StatefulWidget {
  const PFDViewerPage({
    super.key,
  });

  @override
  PFDViewerPageState createState() => PFDViewerPageState();
}

class PFDViewerPageState extends State<PFDViewerPage> {
  Future<bool> onBackPressed() async {
    return Future.value(false);
  }

  bool isLoading = true;
  File? file;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });

    var data = Get.arguments;
    file = data['file'] as File;
    setState(() {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context: context, heading: "Invoice", widgetList: [
        isLoading
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  Share.shareXFiles([XFile(file!.path)], text: 'Claim Sheet');
                },
                icon: const Icon(
                  Icons.share,
                  color: whiteColor,
                ))
      ]),
      body: isLoading
          ? const CommonLoader()
          : PDFView(
              filePath: file!.path,
            ),
    );
  }
}
