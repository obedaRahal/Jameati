import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';

class VerificationBanner extends StatelessWidget {
  final String message;
  final CustomAppColors colors;

  const VerificationBanner({
    super.key,
    required this.message,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colors.cyenToWhite_greyInputDark,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        textAlign: TextAlign.center,
        message,
        style: TextStyle(
          fontSize: 22.sp,
          color: colors.primary_cyen,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
