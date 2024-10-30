import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:caspro_enterprises/Utils/app_images.dart';
import 'package:caspro_enterprises/Widgets/input_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchWidget extends StatelessWidget {
  final VoidCallback fromOnTap, toOnTap, onSearch;
  final TextEditingController fromdate, toDate;
  const SearchWidget(
      {super.key,
      required this.fromOnTap,
      required this.toOnTap,
      required this.fromdate,
      required this.toDate,
      required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: secondaryColor,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
              child: DateFilterTextField(
                rOnly: true,
                controllerValue: fromdate,
                onTap: fromOnTap,
                hint: "From Date",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: DateFilterTextField(
                rOnly: true,
                controllerValue: toDate,
                onTap: toOnTap,
                hint: "Upto Date",
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: onSearch,
              child: SvgPicture.asset(
                AppImages.search,
                height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
