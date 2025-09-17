import 'package:get/get.dart';
import 'package:project_manag_ite/controller/serv/theme_controller.dart';

class MyImageAsset {
  static String get _baseImage {
    final isDark = Get.find<ThemeController>().isDark;
    return isDark ? 'assets/images/dark' : 'assets/images/light';
  }

  static const _baseIcon = 'assets/icons';
  static const _baseLottie = 'assets/lottie';
  static const _baseGif = 'assets/gif';

  // onboarding
  static String get onBoarding1 => '$_baseImage/onboarding1.svg';
  static String get onboarding22 => '$_baseImage/onboarding22.svg';
  static String get onBoarding3 => '$_baseImage/onboarding3.svg';

  // welcome
  static String get welcome => '$_baseImage/welcome.svg';
  static const feather = '$_baseIcon/feather.svg';

  // forget password
  static String get forgetpass1 => '$_baseImage/forgetPass1.svg';
  static String get forgetpass2 => '$_baseImage/forgetPass2.svg';
  static String get forgetpass3 => '$_baseImage/forgetPass3.svg';

  //loading
  //static String get loadingLottie => '$_baseLottie/loading.lottie';
  static String get loadingGif => '$_baseGif/loading.gif';

  //home
  static String get imgIcon => '$_baseIcon/imageIcon.svg';
  static String get pdfIcon => '$_baseIcon/pdfIcon.svg';
  static String get photoImage => '$_baseImage/photeImage.svg';
  static String get pdfImage => '$_baseImage/pdfImage.svg';
  static String get lampOutLine => '$_baseImage/lamp.svg';
  static String get form2 => '$_baseImage/form2.svg';
  static String get sixthPerson => '$_baseImage/sixth person.svg';
  static String get statistic1 => '$_baseImage/statistic1.svg';
  static String get statistic2 => '$_baseImage/statistic2.svg';
  static String get statistic3 => '$_baseImage/statistic3.svg';
  static String get lamp2 => '$_baseIcon/lamp2.png';

  //static String get obeda => '$_baseIcon/obeda.jpg';

  // create group
  static String get groupPic => '$_baseIcon/group_pic.svg';
  // my group
  static String get myGroupMainInfo1 => '$_baseIcon/myGroupMainInfo1.svg';
  static String get myGroupMainInfo2 => '$_baseIcon/myGroupMainInfo2.svg';
  static String get myGroupMainInfo3 => '$_baseIcon/myGroupMainInfo3.svg';
  static String get myGroupMainInfo4 => '$_baseIcon/myGroupMainInfo4.svg';

  //icons
  static String get pdfAdv => '$_baseIcon/pdfAdv.svg';
  static String get imgAdv => '$_baseIcon/imgAdv.svg';
  static String get profileNoPic => '$_baseIcon/profileNoPic.svg';
  static String get groupNoPic => '$_baseIcon/groupNoPic.svg';
}
