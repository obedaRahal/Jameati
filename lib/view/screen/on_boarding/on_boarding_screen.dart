import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:project_manag_ite/controller/onboarding/onboarding_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/data/datasource/static/static.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_button.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_indicator.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_onboarding_pagecontent.dart';

class OnBoardingScreen extends GetView<OnBoardingControllerImp> {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    final controller = Get.find<OnBoardingControllerImp>();
    //Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: PageContentOnBoarding(
                        pageController: controller.pageController,
                      )),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .47,
              left: 0,
              right: 0,
              child: Align(
                  //alignment: Alignment.bottomCenter,
                  child: CustomIndicatorOnBoarding(
                pageController: controller.pageController,
                pageCount: onBoardingList.length,
                
                onDotClicked: (index) {
                  controller.pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                  controller.onPageChanged(index);
                },
                dotColor: colors.cyenToWhite_greyInputDark,
                activeDotColor: colors.greyHint_authTabUnselectedText,
              )),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButtonOnBoarding(
                    text: "تخطي",
                    textColor: colors.mainColor,
                    buttonColor: colors.white_textDark,
                    onPressed: () {
                      controller.skip();
                      
                    },
                  ),
                  CustomButtonOnBoarding(
                    text: "التالي",
                    textColor: colors.subtitleText,
                    buttonColor: colors.mainColor,
                    onPressed: () {
                      controller.next();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
