import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/styles/colors.dart';

class CustomTextField1 extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextField1({
    Key? key,
    this.contentPadding = const EdgeInsets.fromLTRB(13, 20, 13, 20),
    this.controller,
    this.obscureText = false,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon, this.formKey, this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
            fontSize: 12.sp,
            color: AppColor.txtColorMain,
            fontFamily: "poppinsRegular"),
        contentPadding: contentPadding,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.txtColorMain, width: 0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColor.txtColorMain, width: 0.8),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColor.txtColorMain, width: 0.8), // Specify error border
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: AppColor.txtColorMain, width: 0.8), // Specify error border
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class CustomTextField2 extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool readOnly;
  final Future<void> Function()? onChanged;

  const CustomTextField2({
    super.key,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.formKey,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        onChanged: (value) {},
        readOnly: readOnly,
        validator: validator,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: obscureText ? 1 : null, // Single line if obscureText is true, else multi-line
        minLines: 1,
        decoration: InputDecoration(
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          hintStyle: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontSize: 12.sp,
            color: AppColor.txtColorMain,
            fontFamily: "poppinsRegular",
          ),
          contentPadding: const EdgeInsets.fromLTRB(5, 0, 0,5), // Add content padding back
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.txtColorMain, width: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.txtColorMain, width: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.txtColorMain, width: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColor.txtColorMain, width: 0.8),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

