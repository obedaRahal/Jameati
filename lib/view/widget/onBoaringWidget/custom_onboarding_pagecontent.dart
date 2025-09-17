import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:project_manag_ite/controller/onboarding/onboarding_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/data/datasource/static/static.dart';

class PageContentOnBoarding extends GetView<OnBoardingControllerImp> {
  const PageContentOnBoarding({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
        final colors = Theme.of(context).extension<CustomAppColors>()!;

    return PageView.builder(
      onPageChanged: (value) {
        debugPrint("im at pageeee $value");
        controller.onPageChanged(value);
        debugPrint("and current page is  ${controller.currentPage}");
      },
      controller: pageController,
      itemCount: onBoardingList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: SvgPicture.asset(
                  onBoardingList[index].image!,
                  height: MediaQuery.of(context).size.height * 0.45,
                  //fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                onBoardingList[index].title!,
                style: TextStyle(
                  color: colors.titleText,
                  fontSize: MediaQuery.of(context).size.height * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                onBoardingList[index].body!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.titleText,
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                  
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
