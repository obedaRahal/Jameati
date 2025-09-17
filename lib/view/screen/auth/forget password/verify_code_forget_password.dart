import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/forget%20password/verify_code_forgetpassword_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/functions/valid_input.dart';
import 'package:project_manag_ite/view/widget/auth/custom_confirm_button.dart';
import 'package:project_manag_ite/view/widget/auth/forget%20password/top_part_label_screen.dart';
import 'package:project_manag_ite/view/widget/auth/register_verificat.dart/otp_input_section.dart';
import 'package:project_manag_ite/view/widget/auth/register_verificat.dart/resend_code.dart';

class VerifyCodeForgetPasswordScreen extends StatelessWidget {
  const VerifyCodeForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    final controller = Get.find<VerifyCodeForgetPasswordControllerImp>();

    return Scaffold(
      backgroundColor: colors.backgroundWhite,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopPartForgetPasswordLabel(
                  imagePath: MyImageAsset.forgetpass2,
                  title: "تأكيد البريد المدخل",
                  bodyTitle:
                      "الرجاء ادخال الرمز المكون من ستة أرقام الى بريدك الخاص",
                  screenHeight: MediaQuery.of(context).size.height,
                  colors: colors,
                  imgHeight: 0.25,
                ),
            
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.h),
                  child: OtpInputSection(
                    validator: (val) {
                      return validInput(val!, 6, 6, "number");
                    },
                    //otpController: controller.code,
                    colors: colors,
                            
                    onCompleted: (value) {
                      debugPrint("رمز OTP المدخل: $value");
                      controller.verifyCode = value;
                    },
                    widgetConfirm: Column(
                      children: [
                        GetBuilder<VerifyCodeForgetPasswordControllerImp>(
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
                                            .sendVerifyCodeAndGoToNewwPassword();
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
