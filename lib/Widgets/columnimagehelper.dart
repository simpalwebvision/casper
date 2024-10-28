import 'package:flutter/material.dart';

class ColumnImageTextHelper extends StatelessWidget {
  final double? sHeight;
  final String? imagePath;
  final String? title;
  final VoidCallback? onCLicked;
  const ColumnImageTextHelper(
      {super.key, this.sHeight, this.imagePath, this.onCLicked, this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCLicked,
      child: Column(
        children: [
          Image.asset(
            imagePath!,
            height: sHeight! * 0.08,
          ),
          Text(title!)
        ],
      ),
    );
  }
}
