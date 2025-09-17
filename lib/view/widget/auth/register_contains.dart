import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/auth/log_reg_switcher_controller.dart';
import 'package:project_manag_ite/controller/auth/register_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/core/constant/image_asset.dart';
import 'package:project_manag_ite/view/widget/auth/custom_confirm_button.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';
import 'package:project_manag_ite/view/widget/auth/register_verificat.dart/specification_field.dart';
import 'package:project_manag_ite/view/widget/auth/tabs_header.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class RegisterContains extends StatefulWidget {
  const RegisterContains({super.key});

  @override
  State<RegisterContains> createState() => _RegisterContainsState();
}

class _RegisterContainsState extends State<RegisterContains> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final logRegController = Get.find<LoginRegisterSwitcherControllerImp>();

    //RegisterControllerImp controller = Get.put(RegisterControllerImp());
    final RegisterControllerImp controller = Get.find<RegisterControllerImp>();

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
                  SizedBox(height: 12.h),
                  FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) {
                      //return validInput(val!, 4, 30, "number");
                    },
                    label: "الرقم الجامعي",
                    hint: "ادخل الرقم الجامعي الخاص بك...",
                    icon: Icons.format_list_numbered_rounded,
                    myController: controller.univercityNum,
                  ),
                  FormFieldLabelAndInput(
                    isNumber: false,
                    validator: (val) {
                      //return validInput(val!, 10, 30, "email");
                    },
                    label: "البريد الإلكتروني",
                    hint: "ادخل البريد الخاص بك...",
                    icon: Icons.email_outlined,
                    myController: controller.email,
                  ),
                  GetBuilder<RegisterControllerImp>(
                    builder: (controller) => FormFieldLabelAndInput(
                      onTapIcon: () {
                        controller.showPassword();
                      },
                      obscureText: controller.isShowPassword,
                      isNumber: false,
                      validator: (val) {
                        //return validInput(val!, 6, 20, "password");
                      },
                      label: "كلمة المرور",
                      hint: "ادخل كلمة المرور الخاصة بك...",
                      icon: Icons.remove_red_eye_outlined,
                      myController: controller.password,
                    ),
                  ),

                  //////////////////// هنا يجب تمرير الكونترولؤ لل تخصص and validator from it
                  CustomTitleText(
                    text: "التخصص",
                    isTitle: true,
                    textAlign: TextAlign.right,
                    textColor: colors.titleText,
                    screenHeight: MediaQuery.of(context).size.height * .65,
                    horizontalPadding:
                        MediaQuery.of(context).size.height * .025,
                  ),
                  const SpecificatSelector(),
                  SizedBox(height: 50.h),

                  GetBuilder<RegisterControllerImp>(
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
                                  "im it register contains at ConfirmButton");
                              if (_formKey.currentState!.validate()) {
                                debugPrint("Valid register");
                                controller.register();
                              } else {
                                debugPrint("Invalid register");
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

          // زرّين في الأعلى (تسجيل دخول / حساب جديد)
          Positioned(
            //top: 0,
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
