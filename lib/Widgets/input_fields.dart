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
      style: GoogleFonts.poppins(fontSize: 14, color: blackColor),
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
          errorStyle: GoogleFonts.poppins(color: Colors.red),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
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
          labelStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)),
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
      style: GoogleFonts.poppins(
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
            style: GoogleFonts.poppins(),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          filled: true,
          fillColor: Colors.white,
          counterText: '',
          hintText: hintValue,
          hintStyle: GoogleFonts.poppins(
            fontSize: size.width * 0.034,
            color: Colors.black38,
            letterSpacing: 1,
          ),
          errorStyle: GoogleFonts.poppins(
              color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: secondaryColor, width: 1.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red)),
          labelStyle: GoogleFonts.poppins(
            fontSize: size.width * 0.034,
            color: Colors.black,
            letterSpacing: 1,
          )),
    );
  }
}

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color fillColor;
  final TextStyle? textStyle;
  final ValueChanged<String>? onChanged;

  const SearchTextField({
    super.key,
    required this.controller,
    this.hintText = 'Search ...',
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.blue,
    this.errorBorderColor = Colors.red,
    this.fillColor = Colors.white,
    this.textStyle,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: textStyle ??
            GoogleFonts.poppins(
              fontSize: 14,
            ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: borderColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: focusedBorderColor, width: 1.8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: errorBorderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: errorBorderColor),
          ),
          filled: true,
          fillColor: fillColor,
        ),
      ),
    );
  }
}

class DateFilterTextField extends StatelessWidget {
  final String hint;
  final VoidCallback? onTap;
  final bool? rOnly;
  final TextEditingController? controllerValue;
  final TextAlign? textAlignment;
  const DateFilterTextField(
      {super.key,
      this.rOnly = false,
      this.textAlignment,
      required this.hint,
      required this.onTap,
      required this.controllerValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.poppins(fontSize: 13, color: Colors.black),
      controller: controllerValue,
      onTap: onTap,
      readOnly: rOnly!,
      textAlign: textAlignment ?? TextAlign.center,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hint,
        labelStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.black87),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Colors.grey,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}
