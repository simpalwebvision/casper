import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/app_constants.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController? controllerValue;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Widget? pref, suf;
  final bool? rOnly;
  final TextInputType? inputType;
  final TextInputAction? actionNext;
  final bool? obsText;
  final int? mLength;

  final String? Function(String?)? validate;
  final String? hintText;
  const LoginTextField(
      {super.key,
      this.pref,
      this.suf,
      this.controllerValue,
      this.obsText = false,
      this.validate,
      this.onTap,
      this.rOnly = false,
      this.inputType,
      this.actionNext,
      this.mLength,
      this.hintText,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      style: GoogleFonts.mukta(fontSize: 14, color: blackColor),
      cursorColor: primaryColor,
      readOnly: rOnly!,
      textInputAction: actionNext,
      onTap: onTap,
      keyboardType: inputType,
      obscureText: obsText!,
      validator: validate!,
      controller: controllerValue!,
      maxLength: mLength,
      decoration: InputDecoration(
          prefixIcon: pref,
          suffixIcon: suf,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          filled: true,
          fillColor: whiteColor,
          counterText: '',
          errorStyle: GoogleFonts.mukta(color: Colors.red),
          hintText: hintText,
          hintStyle: GoogleFonts.mukta(
            color: blackColor,
            fontSize: 12,
            letterSpacing: 1,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: primaryColor, width: 1)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          labelStyle: const TextStyle(fontSize: 14, color: Colors.black87)),
    );
  }
}

class StepperTextField extends StatelessWidget {
  final TextEditingController? controllerValue;
  final VoidCallback? onTap;
  final Function(String)? onChange;
  final Widget? suf, pre;
  final bool? rOnly;
  final TextInputType? inputType;
  final TextInputAction? actionNext;
  final bool? obsText, alignLabelWithHint;
  final int? maxLine, mLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? label;

  final String? Function(String?)? validate;
  final String? hintValue;
  const StepperTextField(
      {super.key,
      this.suf,
      this.pre,
      this.label,
      this.controllerValue,
      this.obsText = false,
      this.validate,
      this.onTap,
      this.rOnly = false,
      this.inputType,
      this.inputFormatters,
      this.actionNext,
      this.mLength,
      this.alignLabelWithHint,
      this.maxLine,
      this.hintValue,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextFormField(
      onChanged: onChange,
      style: GoogleFonts.mukta(
        fontSize: size.width * 0.034,
        color: Colors.black,
        letterSpacing: 1,
      ),
      cursorColor: Colors.black87,
      readOnly: rOnly!,
      onTap: onTap,
      obscureText: obsText!,
      keyboardType: inputType,
      validator: validate!,
      controller: controllerValue!,
      maxLength: mLength,
      inputFormatters: inputFormatters ?? [],
      decoration: InputDecoration(
          alignLabelWithHint: alignLabelWithHint ?? true,
          prefixIcon: pre,
          suffixIcon: suf,
          label: Text(
            label ?? hintValue!,
            style: GoogleFonts.mukta(),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          filled: true,
          fillColor: Colors.white,
          counterText: '',
          hintText: hintValue,
          hintStyle: GoogleFonts.mukta(
            fontSize: size.width * 0.034,
            color: Colors.black38,
            letterSpacing: 1,
          ),
          errorStyle: GoogleFonts.mukta(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
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
          labelStyle: GoogleFonts.mukta(
            fontSize: size.width * 0.034,
            color: Colors.black,
            letterSpacing: 1,
          )),
    );
  }
}
