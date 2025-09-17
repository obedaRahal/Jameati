import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/verificat_register_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/functions/valid_input.dart';
import 'package:project_manag_ite/view/widget/auth/custom_confirm_button.dart';
import 'package:project_manag_ite/view/widget/auth/register_verificat.dart/otp_input_section.dart';
import 'package:project_manag_ite/view/widget/auth/register_verificat.dart/resend_code.dart';
import 'package:project_manag_ite/view/widget/auth/register_verificat.dart/verificat_banner.dart';
import 'package:project_manag_ite/view/widget/common/back_with_text.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class VerificationRegisterScreeen extends StatelessWidget {
  const VerificationRegisterScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    VerificatRegisterControllerImp controller =
        Get.put(VerificatRegisterControllerImp());

    return Scaffold(
        backgroundColor: colors.mainColor,
        body: SafeArea(
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: BackWithText(
                    onTap: () => Get.back(),
                    iconColor: colors.subtitleText,
                    textColor: colors.subtitleText,
                  ),
                ),
                Expanded(
                    flex: 2,
                    child: LayoutBuilder(builder: (context, constraints) {
                      double totalHeight = constraints.maxHeight;

                      double bottomHeight =
                          MediaQuery.of(context).size.height * .62;
                      double topHeight = totalHeight - bottomHeight;

                      if (topHeight < 0) topHeight = 0;
                      if (bottomHeight < 0) bottomHeight = 0;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          TopPartVerificatReg(
                            topHeight: topHeight,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: bottomHeight,
                              child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  decoration: BoxDecoration(
                                    color: colors.backgroundWhite,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(70),
                                      topRight: Radius.circular(70),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13),
                                        child: OtpInputSection(
                                          validator: (val) {
                                            return validInput(
                                                val!, 6, 6, "number");
                                          },
                                          //otpController: controller.code,
                                          colors: colors,

                                          onCompleted: (value) {
                                            debugPrint(
                                                "رمز OTP المدخل: $value");
                                            controller.verifyCode = value;
                                            debugPrint(
                                                "codeeeeeeeee is ${controller.verifyCode}");
                                          },
                                          widgetConfirm:
                                          GetBuilder<VerificatRegisterControllerImp>(
                              builder: (controller) {
                                switch (controller.statusRequest) {
                                  case StatusRequest.loading:
                                  
                                    return Center(
                                        child: Image.asset(
                                      MyImageAsset.loadingGif,
                                      height: 50.h,
                                    ));

                                  case StatusRequest.offlinefailure:
                                    return const Center(
                                        child:
                                            Text("لا يوجد اتصال بالإنترنت."));
                                  case StatusRequest.serverfaliure:
                                    return const Center(
                                        child: Text(
                                            "خطأ في الخادم. حاول لاحقاً."));

                                  case StatusRequest.success:
                                  case StatusRequest.failure:
                                  case StatusRequest.none:
                                  default:
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: ConfirmButton(onPressed: () {
                                            debugPrint(
                                                "im at forget pas 22222222222 going to 3");
                                            //debugPrint("and codee isssss ${controller.code}");
                                            controller
                                                .sendVerifyCode();
                                          }),
                                        ),
                                        ResendCodeRow(
                                          onResend: () {
                                            debugPrint(
                                                "تم طلب إعادة إرسال الرمز");
                                            controller.resendCode();
                                          },
                                          colors: colors,
                                        ),
                                      ],
                                    );
                                }
                              },
                            ),
                                          ),
                                      ),
                                      Positioned(
                                        top:
                                        25,
                                          //MediaQuery.of(context).size.height *.03,
                                        right: 0,
                                        left: 0,
                                        child: VerificationBanner(
                                          message:
                                              "نحن نقوم بإجراء احترازي فقط",
                                          colors: colors,
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      );
                    }))
              ],
            ),
          ),
        ));
  }
}

class TopPartVerificatReg extends StatelessWidget {
  const TopPartVerificatReg({super.key, required this.topHeight});
  final double topHeight;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    return SizedBox(
      height: topHeight,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CustomTitleText(
              text: 'تأكيد البريد الالكتروني',
              isTitle: true,
              textAlign: TextAlign.right,
              textColor: colors.subtitleText,
              screenHeight: 880.sp
            ),
            //const SizedBox(height: 5),
            CustomTitleText(
              maxLines: 3,
              text:
                  "عزيزي المستخدم يرجى منك تأكيد بريدك الالكتروني عن طريق ادخال الرمز المكون من ستة أرقام علما انك ستفقد الرمز الخاص بك في حال المغادرة",
              isTitle: false,
              textAlign: TextAlign.right,
              textColor: colors.subtitleText,
              screenHeight: 900.sp,
            ),
          ],
        ),
      ),
    );
  }
}
