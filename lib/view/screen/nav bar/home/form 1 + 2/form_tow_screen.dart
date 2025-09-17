import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/controller/nav_bar/home/form%201%20+%202/form_tow_controller.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/colors.dart';
import 'package:project_manag_ite/view/widget/auth/formfeild_lapel_input.dart';
import 'package:project_manag_ite/view/widget/home/custom_background_with_child.dart';
import 'package:project_manag_ite/view/widget/onBoaringWidget/custom_title_text.dart';

class FormTowScreen extends StatelessWidget {
  const FormTowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;
    final controller = Get.find<FormTowControllerImp>();

    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: EdgeInsets.all(18.h),
          child: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomTitleText(
                        text: "تقديم استمارة 2",
                        isTitle: true,
                        screenHeight: 600.sp,
                        textColor: colors.titleText,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_forward_ios,
                            color: colors.titleText, size: 30.h),
                      ),
                    ],
                  ),
                  Divider(
                    color: colors.greyInput_greyInputDark,
                    thickness: 2,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: FormFieldLabelAndInput(
                      isNumber: false,
                      validator: (val) {},
                      label: "اسم الفكرة باللغة العربية",
                      hint: "ادخل اسم الفكرة الخاصة بك باللغة العربية...",
                      icon: Icons.abc,
                      myController: controller.arabicTitle,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: FormFieldLabelAndInput(
                      isNumber: false,
                      validator: (val) {},
                      label: "شريحة المستخدمين",
                      hint: "ادخل الشريحة المستخدمة...",
                      icon: FontAwesomeIcons.user,
                      myController: controller.userSegment,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: FormFieldLabelAndInput(
                      isNumber: false,
                      validator: (val) {},
                      label: "اجرائية التطوير",
                      hint: "ادخل اجرائيات التطوير...",
                      icon: Icons.developer_mode_outlined,
                      myController: controller.developmentProcedure,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: FormFieldLabelAndInput(
                      isNumber: false,
                      validator: (val) {},
                      label: "المكتبات والأدوات",
                      hint: "ادخل المكتبات او الأدوات المستخدمة...",
                      icon: Icons.library_books_rounded,
                      myController: controller.libraryTools,
                    ),
                  ),
                  Obx(() => FormFieldLabelAndPicker(
                        label: "خارطة التنفيذ (PDF)",
                        hint: "اختر ملف PDF لخارطة التنفيذ...",
                        fileName: controller.executionMap.value?.name,
                        onPick: controller.pickExecutionMap,
                        onPreview: controller.executionMap.value != null
                            ? () => controller
                                .previewPdf(controller.executionMap.value)
                            : null,
                        onClear: controller.executionMap.value != null
                            ? controller.clearExecutionMap
                            : null,
                      )),
                  SizedBox(height: 10.h),
                  Obx(() => FormFieldLabelAndPicker(
                        label: "خارطة العمل (PDF)",
                        hint: "اختر ملف PDF لخارطة العمل...",
                        fileName: controller.workMap.value?.name,
                        onPick: controller.pickWorkMap,
                        onPreview: controller.workMap.value != null
                            ? () =>
                                controller.previewPdf(controller.workMap.value)
                            : null,
                        onClear: controller.workMap.value != null
                            ? controller.clearWorkMap
                            : null,
                      )),
                  SizedBox(
                    height: 16.h,
                  ),
                  GetBuilder<FormTowControllerImp>(builder: (controller) =>
                    controller.statusRequest == StatusRequest.loading
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {
                                controller.creteFormTow();
                                debugPrint("send 2222");
                              },
                              child: CustomBackgroundWithWidget(
                                height: 40.h,
                                width: 150.w,
                                color: colors.primary_cyen,
                                borderRadius: 15,
                                alignment: Alignment.center,
                                child: CustomTitleText(
                                  horizontalPadding: 5.h,
                                  text: "إرسال الاستمارة",
                                  isTitle: true,
                                  maxLines: 1,
                                  screenHeight: 400.sp,
                                  textAlign: TextAlign.center,
                                  textColor: AppColors.white,
                                ),
                              ),
                            ))
                  )
                ],
              ),
            ),
          )),
    ));
  }
}

class FormFieldLabelAndPicker extends StatelessWidget {
  const FormFieldLabelAndPicker({
    super.key,
    required this.label,
    required this.hint,
    required this.fileName,
    required this.onPick,
    this.onPreview,
    this.onClear,
  });

  final String label;
  final String hint;
  final String? fileName; // null أو اسم الملف
  final VoidCallback onPick; // اختيار ملف
  final VoidCallback? onPreview; // معاينة
  final VoidCallback? onClear; // مسح

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<CustomAppColors>()!;

    final hasFile = (fileName?.isNotEmpty ?? false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTitleText(
          text: label,
          isTitle: true,
          textAlign: TextAlign.right,
          textColor: colors.titleText,
          screenHeight: 500.h,
          horizontalPadding: 20.h,
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onPick,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black12, width: 1.2),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    hasFile ? fileName! : hint,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: hasFile ? null : Colors.grey),
                  ),
                ),
                if (hasFile && onPreview != null) ...[
                  const SizedBox(width: 8),
                  OutlinedButton.icon(
                    onPressed: onPreview,
                    icon: const Icon(Icons.visibility, size: 18),
                    label: const Text("معاينة"),
                  ),
                ],
                if (hasFile && onClear != null) ...[
                  const SizedBox(width: 6),
                  IconButton(
                    onPressed: onClear,
                    icon: const Icon(Icons.close, size: 18),
                    tooltip: 'مسح',
                  ),
                ],
                const Icon(Icons.picture_as_pdf),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
