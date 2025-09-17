import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';

class ResendCodeRow extends StatelessWidget {
  final VoidCallback onResend;
  final CustomAppColors colors;

  const ResendCodeRow({
    super.key,
    required this.onResend,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onResend,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height * .02,),
            child: Text(
              "إعادة ارسال الرمز",
              style: TextStyle(
                fontSize: 15.sp,
                color: colors.primary_cyen,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          "ألم تستلم رمز بعد ؟ ",
          style: TextStyle(
            fontFamily: MyFonts.hekaya,
            fontSize:  15.sp,
            color: colors.greyHint_authTabUnselectedText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
