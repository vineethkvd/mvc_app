import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../configs/styles/colors.dart';
class CustomElevatedBtnTwo extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final Color? txtColor;
  final double width;
  final Widget? child;
  final double radius;
  final double fontSize;
  final BorderSide? side;
  final String title;
  final TextStyle? textStyle;

  const CustomElevatedBtnTwo({
    Key? key,
    this.side,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    this.radius = 10,
    this.title = '', this.textStyle, this.txtColor,  this.fontSize=13,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shadowColor: Colors.black54,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child ??
          Text(
            title,
            maxLines: 2,
            style: TextStyle(
                fontSize: fontSize,
                color: Colors.white,
                fontFamily: "poppinsSemiBold"),
          ),
    );
  }
}

class CustomTextBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? txtColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget? child;
  final double radius;
  final String title;

  const CustomTextBtn({
    Key? key,
    this.width = double.infinity,
    this.height = 48,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.child,
    this.radius = 10,
    this.title = '', this.txtColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child ??
          Text(
            title,
            style:  TextStyle(
              color: txtColor,
                fontSize: 14.sp,
                fontFamily: "poppinsSemiBold"
            ),
          ),
    );
  }
}
