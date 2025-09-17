
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';

class AuthTabsHeader extends StatelessWidget {
  final String selectedTab; // "login" or "register"
  final VoidCallback onLoginTap;
  final VoidCallback onRegisterTap;

  const AuthTabsHeader({
    super.key,
    required this.selectedTab,
    required this.onLoginTap,
    required this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLoginSelected = selectedTab == "login";
    final bool isRegisterSelected = selectedTab == "register";

    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 22.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AuthTabButton(
            title: "تسجيل الدخول",
            isSelected: isLoginSelected,
            onTap: onLoginTap,
            colors: colors,
            
          ),
          AuthTabButton(
            title: "حساب جديد",
            isSelected: isRegisterSelected,
            onTap: onRegisterTap,
            colors: colors,
          ),
        ],
      ),
    );
  }
}


class AuthTabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final CustomAppColors colors;

  const AuthTabButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       elevation: 0,
//       color: isSelected ? colors.cyenToWhite_greyInputDark : null,
//       onPressed: onTap,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(30),
//       ),
//       padding:  EdgeInsets.symmetric(horizontal: 24.h, vertical: 0),
//       child: Text(
//         title,
//         style: TextStyle(
//           fontSize: 18.sp,
//           color: isSelected
//               ? colors.primary_cyen
//               : colors.greyHint_authTabUnselectedText,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }


@override
Widget build(BuildContext context) {
  return MaterialButton(
    elevation: 0,
    color: isSelected ? colors.cyenToWhite_greyInputDark : null,

    // ✅ شرط يمنع تنفيذ onTap بدون تعطيل الزر (للحفاظ على الشكل)
    onPressed: () {
      if (!isSelected) onTap();
    },

    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18.sp,
        color: isSelected
            ? colors.primary_cyen
            : colors.greyHint_authTabUnselectedText,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

}