import 'package:flutter/material.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class BackWithText extends StatelessWidget {
  final VoidCallback onTap;
  final Color iconColor;
  final Color textColor;
  final String text ;

  const BackWithText({
    super.key,
    required this.onTap,
    required this.iconColor,
    required this.textColor,
    this.text = "رجوع",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(Icons.arrow_back_ios, color: iconColor, size: 30),
          CustomTitleText(
            text: text,
            isTitle: true,
            textAlign: TextAlign.right,
            textColor: textColor,
            screenHeight: MediaQuery.of(context).size.height * .7,
          ),
        ],
      ),
    );
  }
}
