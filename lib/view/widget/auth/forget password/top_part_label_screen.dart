
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/common/back_with_text.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class TopPartForgetPasswordLabel extends StatelessWidget {
  final String imagePath;
  final String title;
  final String bodyTitle;
  final double screenHeight;
  final double imgHeight;
  final CustomAppColors colors;

  const TopPartForgetPasswordLabel({
    super.key,
    required this.imagePath,
    required this.title,
    required this.bodyTitle,
    required this.screenHeight,
    required this.colors,
    required this.imgHeight
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: screenHeight * 0.5,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: colors.cyenToWhite_greyInputDark,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               SizedBox(height: MediaQuery.of(context).size.height * .01,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: BackWithText(
                  onTap: () => Get.back(),
                  iconColor: colors.titleText,
                  textColor: colors.titleText,
                ),
              ),
              SvgPicture.asset(
                imagePath,
                height: screenHeight * imgHeight,
                fit: BoxFit.cover,
              ),
              CustomTitleText(
                text: title,
                isTitle: true,
                screenHeight: screenHeight*.9,
                textAlign: TextAlign.center,
                textColor: colors.primary_cyen,
              ),
              CustomTitleText(
                text: bodyTitle,
                isTitle: false,
                screenHeight: screenHeight ,
                textAlign: TextAlign.center,
                textColor: colors.titleText,
                horizontalPadding: 80,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
