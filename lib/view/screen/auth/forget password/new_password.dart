import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/forget%20password/new_password_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/core/functions/valid_input.dart';
import 'package:project_manag_ite/view/widget/auth/custom_confirm_button.dart';
import 'package:project_manag_ite/view/widget/auth/forget%20password/top_part_label_screen.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    final controller = Get.find<NewPasswordControllerImp>();

    return Scaffold(
      backgroundColor: colors.backgroundWhite,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TopPartForgetPasswordLabel(
                  imagePath: MyImageAsset.forgetpass3,
                  title: "إنشاء كلمة مرور جديدة",
                  bodyTitle: "يجب ان تكون كلمة المرور الجديدة مختلفة عن السابقة",
                  screenHeight: MediaQuery.of(context).size.height,
                  colors: colors,
                  imgHeight: 0.25,
                ),
            
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GetBuilder<NewPasswordControllerImp>(
                        builder: (controller) => FormFieldLabelAndInput(
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          obscureText: controller.isShowPassword,
                          isNumber: false,
                          validator: (val) {
                            //return validInput(val!, 6, 20, "password");
                          },
                          myController: controller.password,
                          label: "كلمة المرور",
                          hint: "ادخل كلمة المرور الخاصة بك...",
                          icon: Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GetBuilder<NewPasswordControllerImp>(
                        builder: (controller) => FormFieldLabelAndInput(
                          onTapIcon: () {
                            controller.showPassword();
                          },
                          obscureText: controller.isShowPassword,
                          isNumber: false,
                          validator: (val) {
                            //return validInput(val!, 6, 20, "password");
                          },
                          myController: controller.rePassword,
                          label: "تأكيد كلمة المرور",
                          hint: "ادخل كلمة المرور مرة أخرى...",
                          icon: Icons.remove_red_eye,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .045),
                    GetBuilder<NewPasswordControllerImp>(
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
                                    "im at forget pas 3333333 going to home");
                                controller.newPassword();
                                ////////////Get.toNamed(AppRoute.forgetPassword2);
                              }),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
