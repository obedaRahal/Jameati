import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/log_reg_switcher_controller.dart';
import 'package:project_manag_ite/controller/auth/login_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/auth/custom_confirm_button.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';
import 'package:project_manag_ite/view/widget/auth/tabs_header.dart';

class LoginContains extends StatefulWidget {
  const LoginContains({super.key});

  @override
  State<LoginContains> createState() => _LoginContainsState();
}

class _LoginContainsState extends State<LoginContains> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final logRegController = Get.find<LoginRegisterSwitcherControllerImp>();
    final LoginControllerImp controller = Get.find<LoginControllerImp>();

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 75.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 12.h
                      ),
                  FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) => null ,
                    label: "البريد الإلكتروني",
                    hint: "ادخل البريد الخاص بك...",
                    icon: Icons.email_outlined,
                    myController: controller.email,
                  ),
                  GetBuilder<LoginControllerImp>(
                    builder: (controller) => FormFieldLabelAndInput(
                      onTapIcon: () {
                        controller.showPassword();
                      },
                      obscureText: controller.isShowPassword,
                      isNumber: false,
                      validator: (val)  => null ,
                      label: "كلمة المرور",
                      hint: "ادخل كلمة المرور الخاصة بك...",
                      icon: Icons.remove_red_eye_outlined,
                      myController: controller.password,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      onTap: () {
                        controller.goToForgetPassword();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 0,
                        ),
                        child: Text(
                          "نسيت كلمة المرور؟",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: colors.primary_cyen,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 70.h
                      ),
                  GetBuilder<LoginControllerImp>(
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
                          return ConfirmButton(
                            onPressed: () {
                              debugPrint(
                                  "im it loginnnnnnnnnnnnn contains at ConfirmButton");
                              if (_formKey.currentState!.validate()) {
                                debugPrint("Valid login");
                                controller.login();
                              } else {
                                debugPrint("Invalid login");
                              }
                            },
                          );
                      }
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            child: Obx(() => AuthTabsHeader(
                  selectedTab: logRegController.currentIndex.value == 0
                      ? "login"
                      : "register",
                  onLoginTap: logRegController.goToLogin,
                  onRegisterTap: logRegController.goToRegister,
                )),
          ),
        ],
      ),
    );
  }
}
