import 'package:flutter/material.dart';

class CustomButtonOnBoarding extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color buttonColor;
  final VoidCallback onPressed;
  final double fontSize;
  final double paddingVertical;
  final double paddingHorizonal;

  const CustomButtonOnBoarding(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.buttonColor,
      required this.onPressed,
      this.fontSize = 25,
      this.paddingVertical = 0,
      this.paddingHorizonal = 36})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: MaterialButton(
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizonal,
          vertical: paddingVertical,
        ),
        onPressed: onPressed,
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60),
          side:  BorderSide(
            color:
            Theme.of(context).highlightColor,
            //MyColors.primaryColor,
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
