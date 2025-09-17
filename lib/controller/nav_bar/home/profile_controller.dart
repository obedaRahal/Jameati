// ignore_for_file: unused_element

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/constant/route_name.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/profile/my_profile_data.dart';
import 'package:project_manag_ite/data/model/my_profile_model.dart';

abstract class ProfileController extends GetxController {}

class ProfileControllerImp extends ProfileController {
  Rx<File?> pickedImage = Rx<File?>(null);
  String? groupImageUrl; 

  RxString governorate = "اختر المحافظة".obs;
  late TextEditingController phoneNum;
  late TextEditingController birthDate;
  late TextEditingController specification;
  RxString selectedSpecification = ''.obs;

  final List<String> syGovernorates = const [
    'دمشق',
    'ريف دمشق',
    'حلب',
    'حمص',
    'حماة',
    'اللاذقية',
    'طرطوس',
    'إدلب',
    'دير الزور',
    'الرقة',
    'الحسكة',
    'درعا',
    'السويداء',
    'القنيطرة',
  ];

  Map<String, String> codeToArabic = {
    'backend': 'باك ايند',
    'front_mobile': 'فرونت موبايل',
    'front_Web': 'فرونت ويب',
  };

  Map<String, String> arabicToCode = {
    'باك ايند': 'backend',
    'فرونت موبايل': 'front_mobile',
    'فرونت ويب': 'front_Web',
  };

  StatusRequest statusRequest = StatusRequest.none;
  MyProfileModel? myProfileModel;
  final MyProfileData myProfileData = MyProfileData(Get.find());

  String get displayName => myProfileModel?.user?.name ?? '—';
  String get displayEmail => myProfileModel?.user?.email ?? '—';
  String get displayUniversityNumber =>
      myProfileModel?.user?.universityNumber ?? '—';
  String get displayStudentStatus => myProfileModel?.user?.studentStatus ?? '';
  String get displayCreatedAt {
    final raw = myProfileModel?.user?.createdAt;
    if (raw == null || raw.isEmpty) return '—';
    try {
      final dt = DateTime.tryParse(raw);
      if (dt != null) {
        return DateFormat('dd/MM/yyyy', 'ar').format(dt);
      }
      return raw;
    } catch (_) {
      return raw;
    }
  }

  String? sanitizeUrl(String? v) {
    if (v == null) return null;
    final s = v.trim().toLowerCase();
    if (s.isEmpty || s == 'null') return null;
    return v;
  }

  String? _normalizeSpec(String? raw) {
    if (raw == null) return null;
    if (raw.contains('front') && raw.contains('mobile')) return 'front_mobile';
    if (raw.contains('front') && raw.contains('Web')) return 'front_Web';
    if (raw.contains('back')) return 'backend';
    return raw;
  }

  Future<void> getMyProfile() async {
    statusRequest = StatusRequest.loading;
    update();

    final response = await myProfileData.getMyProfile();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          myProfileModel = MyProfileModel.fromJson(response);
          final u = myProfileModel?.user;

          phoneNum.text = u?.phoneNumber ?? '';
          birthDate.text = u?.birthDate ?? '';

          final govRaw = (u?.governorate ?? '').trim();
          governorate.value =
              (govRaw.isNotEmpty && syGovernorates.contains(govRaw))
                  ? govRaw
                  : "دمشق";

          final normalized = _normalizeSpec(u?.studentSpeciality);
          specification.text = normalized ?? ''; 
          selectedSpecification.value =
              codeToArabic[normalized] ?? ''; 

          final img = (u?.profileImage ?? '').trim();
          groupImageUrl =
              (img.isEmpty || img.toLowerCase() == 'null') ? null : img;

          debugPrint("✅ تم جلب بيانات profile بنجاح");
        } catch (e, st) {
          debugPrint("❌ خطأ أثناء تحويل البيانات إلى: $e");
          debugPrintStack(stackTrace: st);
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;
      } else {
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  String get birthDateDisplay =>
      birthSelected != null ? birthSelected!.toDdMmYyyySlash() : '';

  String get birthDateForApi {
    if (birthSelected != null) {
      return birthSelected!.toDdMmYyyySlash();
    }
    final raw = _toWesternDigits(birthDate.text.trim());
    if (raw.isEmpty || !raw.contains('/')) return '';
    try {
      final p = raw.split('/');
      final d = int.parse(p[0]);
      final m = int.parse(p[1]);
      final y = int.parse(p[2]);
      final dt = DateTime(y, m, d);
      return dt.toDdMmYyyySlash();
    } catch (_) {
      return '';
    }
  }

  DateTime? birthSelected;
  Future<void> pickBirthDate(BuildContext context) async {
    final now = DateTime.now();

    DateTime initial =
        birthSelected ?? DateTime(now.year - 20, now.month, now.day);

    final raw = _toWesternDigits(birthDate.text.trim());
    if (raw.isNotEmpty && raw.contains('/')) {
      final parts = raw.split('/');
      if (parts.length == 3) {
        final d = int.tryParse(parts[0]) ?? initial.day;
        final m = int.tryParse(parts[1]) ?? initial.month;
        final y = int.tryParse(parts[2]) ?? initial.year;
        initial = DateTime(y, m, d);
      }
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1950),
      lastDate: now,
      helpText: 'Select birth date',
      cancelText: 'Cancel',
      confirmText: 'OK',
      locale: const Locale('en'),
      builder: (ctx, child) => child!,
    );

    if (picked != null) {
      birthSelected = picked;
      birthDate.text = picked.toDdMmYyyySlash();
      update();
    }
  }

  updateProfileInfo() async {
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at updateProfileInfo is $statusRequest");
    update();
    var response = await myProfileData.postData(
      governorate.value,
      phoneNum.text,
      birthDate.text,
      specification.text,
    );

    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at updateProfileInfo: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint(' updateProfileInfo ناجح - code $code');
        statusRequest = StatusRequest.success;
        getMyProfile();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
          isSuccess: true,
        );
        update();
        return;
      } else if (response.containsKey("title") &&
          response.containsKey("body") &&
          response["statusCode"] != 200) {
        debugPrint("⚠️ نجاح فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
          isSuccess: false,
        );
        //getMyProfile();
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code $code");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }

  updatePrifilePic() async {
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at updatePrifilePic is $statusRequest");
    update();
    var response = await myProfileData.updateProfilePic(
      image: pickedImage.value,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at updatePrifilePic: handling success response");
      final code = response["statusCode"];
      if (code == 200 || code == 201) {
        debugPrint(' updateGroupInfo ناجح - code $code');
        statusRequest = StatusRequest.success;
        getMyProfile();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
          isSuccess: true,
        );
        update();
        return;
      } else if (response.containsKey("title") &&
          response.containsKey("body") &&
          response["statusCode"] != 200) {
        debugPrint("⚠️ نجاح فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تمت العملية",
          isSuccess: false,
        );
        getMyProfile();
        pickedImage.value = null;
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code $code");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }



  logOut() async {

    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\logOut at logOut  is $statusRequest");
    update();
    var response = await myProfileData.getToLogOut();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at logOut: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
        Get.offAllNamed(AppRoute.welccm);
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );
        statusRequest = StatusRequest.failure;

      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر - code $code");
        showCustomSnackbar(
          title: "خطأ في الخادم",
          message: "حدث خطأ غير متوقع، الرجاء المحاولة لاحقًا",
          isSuccess: false,
        );
        statusRequest = StatusRequest.serverfaliure;
      }
    }

    update();
  }


  @override
  void onInit() {
    phoneNum = TextEditingController();
    birthDate = TextEditingController();
    specification = TextEditingController();
    getMyProfile();
    super.onInit();
  }

  @override
  void dispose() {
    phoneNum.dispose();
    birthDate.dispose();
    specification.dispose();
    super.dispose();
  }
}

extension _LatinDate on DateTime {
  String toEnDdMmYyyy() {
    final dd = day.toString().padLeft(2, '0');
    final mm = month.toString().padLeft(2, '0');
    final yyyy = year.toString();
    return '$dd/$mm/$yyyy'; // دائمًا أرقام إنجليزية
  }
}

/// يحوّل أي أرقام عربية/فارسيّة إلى لاتينية
String _toWesternDigits(String input) {
  const eastern = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩'
  ]; // Arabic-Indic
  const persian = [
    '۰',
    '۱',
    '۲',
    '۳',
    '۴',
    '۵',
    '۶',
    '۷',
    '۸',
    '۹'
  ]; // Persian-Indic
  const western = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  var out = input;
  for (int i = 0; i < 10; i++) {
    out = out.replaceAll(eastern[i], western[i]);
    out = out.replaceAll(persian[i], western[i]);
  }
  return out;
}

/// تمديد لتاريخ بصيغة dd/MM/yyyy بأرقام لاتينية دومًا
extension DateFmtX on DateTime {
  String toDdMmYyyySlash() {
    final d = day.toString().padLeft(2, '0');
    final m = month.toString().padLeft(2, '0');
    final y = year.toString().padLeft(4, '0');
    // الأرقام الناتجة لاتينية أصلًا، لكن لو تحب تأمينًا:
    return _toWesternDigits('$d/$m/$y');
  }
}
