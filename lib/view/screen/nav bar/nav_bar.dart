import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:project_manag_ite/controller/nav_bar/nav_bar_controller.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/fonts.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    Get.find<NavBarControllerImpl>();
    return GetBuilder<NavBarControllerImpl>(
      builder: (controller) => Scaffold(
          bottomNavigationBar: Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(200),
              color: Get.find<ThemeController>().isDark
                  ? AppColors.darkPrimary
                  : AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), // لون الظل
                  spreadRadius: 10,
                  blurRadius: 4,
                  offset: const Offset(0, 2), // ❗ offset سلبي = ظل من الأعلى
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: GNav(
                  color: Get.find<ThemeController>().isDark
                      ? AppColors.darkPrimary
                      : AppColors.white,
                  curve: Curves.bounceIn,
                  gap: 0,
                  backgroundColor: Get.find<ThemeController>().isDark
                      ? AppColors.darkPrimary
                      : AppColors.white,
                  activeColor: colors.primary_cyen,
                  tabBackgroundColor: Get.find<ThemeController>().isDark
                      ? const Color(0xff3F3F3F)
                      : AppColors.cyenToWhite,
                  padding:
                       EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  onTabChange: (value) {
                    controller.changePage(value);
                    debugPrint('value of index of nav $value');
                  },
                  iconSize: MediaQuery.of(context).size.height * .028,

                  //textSize: 30,
                  textStyle: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * .019,
                    fontFamily: MyFonts.hekaya,
                    color: colors.primary_cyen,
                  ),
                  tabs: [
                    GButton(
                      icon: FontAwesomeIcons.home,
                      iconColor: Get.find<ThemeController>().isDark
                          ? AppColors.greyHintLight
                          : const Color(0xff444444),
                      text: 'الرئيسية',
                      //iconSize: 26,
                    ),
                    GButton(
                      icon: FontAwesomeIcons.comments,
                      iconColor: Get.find<ThemeController>().isDark
                          ? AppColors.greyHintLight
                          : const Color(0xff444444),
                      text: 'المحادثات',
                    ),
                    GButton(
                      icon: Icons.groups_2_outlined,
                      iconColor: Get.find<ThemeController>().isDark
                          ? AppColors.greyHintLight
                          : const Color(0xff444444),
                      iconSize: MediaQuery.of(context).size.height * .032,
                      text: 'الغروبات',
                    ),
                    GButton(
                      icon: FontAwesomeIcons.search,
                      iconColor: Get.find<ThemeController>().isDark
                          ? AppColors.greyHintLight
                          : const Color(0xff444444),
                      text: 'البحث',
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: controller.listPage.elementAt(controller.currentPage)
          // Center(
          //   child: Text('aaaaaaaaaaaaad'),
          // ),
          ),
    );
  }
}
