
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/auth/custom_textformfeild.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class SearchBarWithClear extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onClear;
  final String hintTextAtSearchBar;
  final Widget actionWidget ;
  final IconData iconData ; 

  const SearchBarWithClear({
    super.key,
    required this.controller,
    required this.onClear, 
    required this.hintTextAtSearchBar, 
    required this.actionWidget, 
    this.iconData = Icons.search,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onClear,
          child: actionWidget
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomTextFormFeild(
            hintText: hintTextAtSearchBar,
            iconData: iconData,
            myComtroller: controller,
            validator: (_) => null,
            isNumber: false,
            iconPosition: IconPosition.suffix,
          ),
        ),
      ],
    );
  }
}
