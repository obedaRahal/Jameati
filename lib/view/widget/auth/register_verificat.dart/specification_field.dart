import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/register_controller.dart';
import 'package:project_manag_ite/core/constant/colors.dart';

class SpecificatSelector extends StatelessWidget {
  const SpecificatSelector({super.key});

  // ✅ تعريف الخريطة هنا داخل الكلاس
  static const Map<String, String> specMap = {
    "باك ايند": "backend",
    "فرونت موبايل": "front_mobile",
    "فرونت ويب": "front_Web",
  };

  @override
  Widget build(BuildContext context) {
    final RegisterControllerImp controller = Get.find();

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          buildSpecButton("باك ايند", controller, context),
          SizedBox(width: 10.w,),
          buildSpecButton("فرونت موبايل", controller, context),
          SizedBox(width: 10.w,),
          buildSpecButton("فرونت ويب", controller, context),
        ],
      );
    });
  }

  Widget buildSpecButton(String title, RegisterControllerImp controller, BuildContext context) {
    final bool isSelected = controller.selectedSpecification.value == title;
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final String? valueToStore = specMap[title]; // ✅ الآن لن يظهر الخطأ

    return OutlinedButton(
      onPressed: () {
        controller.selectedSpecification.value = title;
        controller.specification.text = valueToStore ?? "";
      },
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? colors.cyenToWhite_greyInputDark : Colors.transparent,
        side: isSelected
            ? BorderSide(width: 2, color: colors.greyInput_greyInputDark)
            : BorderSide(color: colors.greyHint_authTabUnselectedText, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding:  EdgeInsets.symmetric(horizontal: 10.h, vertical: 0),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? colors.primary_cyen : colors.greyHint_authTabUnselectedText,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
