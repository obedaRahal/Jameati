
import 'package:flutter/material.dart';
import 'package:project_manag_ite/core/constant/colors.dart';


enum IconPosition {
  prefix,
  suffix,
}

class CustomTextFormFeild extends StatelessWidget {
  const CustomTextFormFeild({
    super.key,
    required this.hintText,
    required this.iconData,
    required this.myComtroller,
    required this.validator,
    required this.isNumber,
    this.obscureText,
    this.onTapIcon,
    this.iconPosition = IconPosition.prefix,
  });

  final String hintText;
  final IconData iconData;
  final TextEditingController myComtroller;
  final String? Function(String?) validator;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  final IconPosition iconPosition;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    final iconWidget = InkWell(
      onTap: onTapIcon,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Icon(
          iconData,
          color: Colors.grey,
          size: MediaQuery.of(context).size.height * .025,
        ),
      ),
    );

    return TextFormField(
      obscureText: obscureText == true,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      validator: validator,
      controller: myComtroller,
      cursorColor: AppColors.greyInput,
      decoration: InputDecoration(
        hintText: hintText,
        hintTextDirection: TextDirection.rtl,
        hintStyle: TextStyle(
          color: AppColors.greyHintLight,
          fontSize: MediaQuery.of(context).size.height * .02,
        ),
        fillColor: colors.greyInput_greyInputDark,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .015,
          horizontal: MediaQuery.of(context).size.height * .025,
        ),
        prefixIcon: iconPosition == IconPosition.prefix ? iconWidget : null,
        suffixIcon: iconPosition == IconPosition.suffix ? iconWidget : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: colors.primary_cyen),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.red),
        ),
      ),
    );
  }
}
