import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/auth/custom_textformfeild.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class FormFieldLabelAndInput extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController myController;
  final String? Function(String?) validator ;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final int fornFeildHigh ;

  const FormFieldLabelAndInput({
    super.key,
    required this.label,
    required this.hint,
    required this.icon, 
    required this.myController, 
    required this.validator, 
    required this.isNumber,
    this.obscureText,
    this.onTapIcon, 
    this.fornFeildHigh = 50
  });

  @override
  Widget build(BuildContext context) {
      final colors = Theme.of(context).extension<CustomAppColors>()!;

    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomTitleText(
          text: label,
          isTitle: true,
          textAlign: TextAlign.right,
          textColor: colors.titleText,
          screenHeight: MediaQuery.of(context).size.height * .65,
          horizontalPadding:  MediaQuery.of(context).size.height * .025,
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: fornFeildHigh.h,
          child: CustomTextFormFeild(
            onTapIcon: onTapIcon,
            obscureText: obscureText,
            isNumber :isNumber,
            validator: validator,
            hintText: hint,
            iconData: icon,
            myComtroller: myController,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
