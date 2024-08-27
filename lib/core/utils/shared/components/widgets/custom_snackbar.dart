import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../configs/styles/colors.dart';

class CustomSnackBar {
  static showCustomSnackBar({required String title, required String message,Duration? duration})
  {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
      colorText: Colors.white,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.check_circle, color: Colors.white,),
    );
  }


  static showCustomErrorSnackBar({required String title, required String message,Color? color,Duration? duration})
  {
    Get.snackbar(
      title,
      message,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.only(top: 10,left: 10,right: 10),
      colorText: Colors.white,
      backgroundColor: color ?? Colors.redAccent,
      icon: const Icon(Icons.error, color: Colors.white,),
    );
  }



  static showCustomToast({String? title, required String message,Color? color,Duration? duration}){
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.green,
      onTap: (snack){
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }


  static showCustomErrorToast({String? title, required String message,Color? color,Duration? duration}){
    Get.rawSnackbar(
      title: title,
      duration: duration ?? const Duration(seconds: 3),
      snackStyle: SnackStyle.GROUNDED,
      backgroundColor: color ?? Colors.redAccent,
      onTap: (snack){
        Get.closeAllSnackbars();
      },
      //overlayBlur: 0.8,
      message: message,
    );
  }

  static showCustomDialog({
    required String title,
    required String middleText,
    required String textConfirm,
    Color? buttonColor,
    double radius = 10.0,
    VoidCallback? onConfirm,
  }) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      title: title,
      textConfirm: textConfirm,
      middleText: middleText,
      titleStyle: TextStyle(
        fontSize: 18.sp, // Adjust the font size as needed
        fontWeight: FontWeight.bold, // Adjust the font weight as needed
      ),
      buttonColor: buttonColor ?? AppColor.appMainColor, // Set the button color
      radius: radius, // Set the border radius
      onConfirm: onConfirm ?? () {
        Get.back();
      },
    );
  }
}