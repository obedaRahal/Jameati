import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';

import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class OtpInputSection extends StatelessWidget {
  final CustomAppColors colors;

  final void Function(String) onCompleted;
  final String? Function(String?) validator;
  final Widget widgetConfirm ;
  //final TextEditingController otpController;

  const OtpInputSection({
    super.key,
    required this.colors,

    required this.onCompleted, 
    required this.validator,
    required this.widgetConfirm
    //required this.otpController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTitleText(
            text: "ادخل الرمز",
            isTitle: true,
            textAlign: TextAlign.right,
            textColor: colors.titleText,
            screenHeight: MediaQuery.of(context).size.height * .65,
            horizontalPadding: MediaQuery.of(context).size.height * .025,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          PinCodeTextField(
            validator: validator,
            //controller: otpController,
            appContext: context,
            length: 6,
            textStyle: TextStyle(
              fontSize: 22,
              color: colors.titleText,
              fontFamily: MyFonts.hekaya,
            ),
            obscureText: false,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: MediaQuery.of(context).size.height * .06,
              fieldWidth: MediaQuery.of(context).size.height * .06,
              activeFillColor: colors.greyInput_greyInputDark,
              selectedFillColor: colors.greyInput_greyInputDark,
              inactiveFillColor: colors.greyInput_greyInputDark,
              inactiveColor: colors.greyInput_greyInputDark,
              selectedColor: colors.mainColor,
              activeColor: colors.primary_cyen,
              errorBorderColor: AppColors.red
              
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            onChanged: (_) {},
            onCompleted: onCompleted,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .06,
          ),
          widgetConfirm
        ],
      ),
    );
  }
}
