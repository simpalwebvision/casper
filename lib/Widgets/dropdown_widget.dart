import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropDownWidget extends StatelessWidget {
  final List? dropMenuList;
  final String? labelText;
  final String? hintText;
  final String? Function(Object?)? validate;
  final String selectedVal;
  final void Function(Object?)? onChanged;
  final bool? isExpand;
  const DropDownWidget({
    super.key,
    required this.dropMenuList,
    required this.labelText,
    this.hintText = "",
    required this.selectedVal,
    required this.onChanged,
    this.validate,
    this.isExpand,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          iconSize: 25,
          icon: const Icon(
            Icons.keyboard_arrow_down_outlined,
          ),
          dropdownColor: whiteColor,
          decoration: InputDecoration(
            errorStyle: GoogleFonts.mukta(
                color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: primaryColor, width: 1.5)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red)),
          ),
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
          isExpanded: isExpand ?? true,
          validator: validate!,
          style: GoogleFonts.mukta(
            fontSize: size.width * 0.034,
            color: Colors.black,
            letterSpacing: 1,
          ),
          hint: Text(
            hintText!,
            style: GoogleFonts.mukta(
              fontSize: size.width * 0.034,
              color: Colors.black,
            ),
          ),
          items: dropMenuList!.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.mukta(),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          value: selectedVal.isEmpty ? null : selectedVal,
        ),
      ),
    );
  }
}
