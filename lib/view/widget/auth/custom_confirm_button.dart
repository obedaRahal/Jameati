import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_button.dart';

class ConfirmButton extends StatelessWidget {
  ConfirmButton({super.key, required this.onPressed});

  void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomButtonOnBoarding(
            text: "تأكيد الإدخال",
            onPressed: onPressed,
            textColor: colors.cyenToWhite_greyInputDark,
            fontSize: 
            20.sp,
            //MediaQuery.of(context).size.height * .025,
            buttonColor: colors.primary_cyen,
            paddingVertical: 9.h,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: colors.greyInput_greyInputDark,
            thickness: 2,
            endIndent: 40.w,
            indent: 40.w,
          ),
        ),
      ],
    );
  }
}
