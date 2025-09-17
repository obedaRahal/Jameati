import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/forget%20password/forget_password_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/auth/custom_confirm_button.dart';
import 'package:project_manag_ite/view/widget/auth/forget%20password/top_part_label_screen.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    ForgetPasswordControllerImp controller =
        Get.put(ForgetPasswordControllerImp());

    return Scaffold(
      backgroundColor: colors.backgroundWhite,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopPartForgetPasswordLabel(
                  imagePath: MyImageAsset.forgetpass1,
                  title: "نسيت كلمة المرور؟",
                  bodyTitle:
                      "يرجى ادخال عنوان بريدك الالكتروني لتتلقى رمز التحقق عليه",
                  screenHeight: MediaQuery.of(context).size.height,
                  colors: colors,
                  imgHeight: 0.25,
                ),
                SizedBox(height: 16.h,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) {
                      //return validInput(val!, 10, 30, "email");
                    },
                    label: "البريد الإلكتروني",
                    hint: "ادخل البريد الخاص بك...",
                    icon: Icons.email_outlined,
                    myController: controller.email,
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height * .055),
                GetBuilder<ForgetPasswordControllerImp>(
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
                            child: Text("لا يوجد اتصال بالإنترنت."));
                      case StatusRequest.serverfaliure:
                        return const Center(
                            child: Text("خطأ في الخادم. حاول لاحقاً."));
                          
                      case StatusRequest.success:
                      case StatusRequest.failure:
                      case StatusRequest.none:
                      default:
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          child: ConfirmButton(onPressed: () {
                            debugPrint(
                                "im at forget pas 11111111111 going to 2");
                            debugPrint(
                                "and email isssss ${controller.email.text}");
                            controller.forgetPasswordAndGoToVerifyCode();
                          }),
                        );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
