import 'dart:io';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/core/functions/validation.dart';
import 'package:project_manag_ite/data/datasource/remote/adv/adv_pdf_data.dart';
import 'package:project_manag_ite/data/model/advvvv/adv_model.dart';

abstract class AdvPdfController extends GetxController {}

class AdvPdfControllerImp extends AdvPdfController {
  RxString selectedScreenPart = "الكل".obs;
  final List<String> screenPart = ["الكل", "السنة الماضية", "المفضلة"];
  RxInt carouselCurrentIndex = 0.obs;
  late CarouselSliderController carouselController = CarouselSliderController();

  StatusRequest statusRequest = StatusRequest.none;
  AdvModel? advModel;
  AdvPdfData advPdfData = AdvPdfData(Get.find());
  RxList<DataAdvModel> latestPdfAdvList = <DataAdvModel>[].obs;

  getListOfLatestNewPdfAdv() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advPdfData.getLatest5AdvPdf();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          latestPdfAdvList.assignAll(parsed.data ?? []);
          //latestAdvList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv {{{{{{{{{{{{{{{{files}}}}}}}}}}}}}}}} بنجاح: ${latestPdfAdvList.length} جروب");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى JoinGroupResponseModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }

  List<DataAdvModel> lastCurrentYearPdfAdvList = [];
  getListOfNewPdfAdvCurrentYear() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advPdfData.getListCurrentYearAdvPdf();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          lastCurrentYearPdfAdvList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv allllllll {{{{{{{{{{{{{{{{files}}}}}}}}}}}}}}}} بنجاح: ${lastCurrentYearPdfAdvList.length} جروب");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى JoinGroupResponseModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }

  Future<String> _saveBytesToFile(
      Uint8List bytes, String filename, String? contentType) async {
    Directory dir;

    if (Platform.isAndroid) {
      dir = (await getExternalStorageDirectory()) ??
          await getTemporaryDirectory();
    } else if (Platform.isIOS) {
      dir = await getApplicationDocumentsDirectory();
    } else {
      dir = await getTemporaryDirectory();
    }

    if (!filename.contains('.')) {
      if ((contentType ?? '').contains('pdf')) {
        filename += '.pdf';
      } else if ((contentType ?? '').contains('png')) {
        filename += '.png';
      } else if ((contentType ?? '').contains('jpeg') ||
          (contentType ?? '').contains('jpg')) {
        filename += '.jpg';
      }
    }

    final filePath = '${dir.path}/$filename';
    final file = File(filePath);
    await file.writeAsBytes(bytes, flush: true);
    return filePath;
  }

  Future<void> downloadAdv(int advId) async {
    try {
      statusRequest = StatusRequest.loading;
      update();

      final either = await advPdfData.getToDownloadAdv(advId);
      await either.fold(
        (err) async {
          statusRequest = err;
          showCustomSnackbar(
            title: "فشل",
            message: "تعذر الاتصال بالخادم",
            isSuccess: false,
          );
        },
        (res) async {
          final ct = (res.headers['content-type'] ?? '').toLowerCase();

          if (res.statusCode >= 400) {
            showCustomSnackbar(
              title: "خطأ",
              message: "HTTP ${res.statusCode}",
              isSuccess: false,
            );
            statusRequest = StatusRequest.serverfaliure;
            return;
          }

          final bytes = res.bodyBytes;

          String filename = 'adv_$advId';
          final cd = res.headers['content-disposition'];
          if (cd != null) {
            final m = RegExp(r'filename\*?=([^;]+)').firstMatch(cd);
            if (m != null) {
              filename = m.group(1)!.replaceAll('"', '').trim();
            }
          }

          final savedPath = await _saveBytesToFile(bytes, filename, ct);

          await OpenFilex.open(savedPath);

          showCustomSnackbar(
            title: "نجاح",
            message: "تم حفظ الملف: $filename",
            isSuccess: true,
          );

          statusRequest = StatusRequest.success;
        },
      );
    } catch (e) {
      debugPrint("✗ downloadAdv error: $e");
      showCustomSnackbar(
        title: "فشل التنزيل",
        message: "حدث خطأ أثناء التنزيل.",
        isSuccess: false,
      );
      statusRequest = StatusRequest.failure;
    } finally {
      update();
    }
  }

  addToFavorite(int advId) async {
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at changeLeader  is $statusRequest");
    update();
    var response = await advPdfData.postToAddToFavorite(advId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint(
          "//////im at add to favorite at advvvv {{{{{{{{{{{{{{{{files}}}}}}}}}}}}}}}}: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        getListOfLatestNewPdfAdv();
        getListOfNewPdfAdvCurrentYear();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );

        statusRequest = StatusRequest.failure;

        getListOfLatestNewPdfAdv();
        getListOfNewPdfAdvCurrentYear();
        getListFavoritePdfAdv();
        getListOfLatestNewPdfAdv();
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

  deleteFromFavorite(int advId) async {
    statusRequest = StatusRequest.loading;
    debugPrint("\\\\\\\\statusRequest at delete favvv  is $statusRequest");
    update();
    var response = await advPdfData.delFromFavorite(advId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint(
          "//////im at delete favv at advvvv {{{{{{{{{{{{{{{{files}}}}}}}}}}}}}}}}: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');

        getListOfLatestNewPdfAdv();
        getListOfNewPdfAdvCurrentYear();
        getListFavoritePdfAdv();
        getListOfLatestNewPdfAdv();
        showCustomSnackbar(
          title: response["title"] ?? "نجاح",
          message: response["body"] ?? "تم بنجاح",
          isSuccess: true,
        );
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - code $code");
        showCustomSnackbar(
          title: response["title"] ?? "خطأ",
          message: response["body"] ?? "تحقق من البيانات المدخلة",
          isSuccess: false,
        );

        statusRequest = StatusRequest.failure;
        getListOfLatestNewPdfAdv();
        getListOfNewPdfAdvCurrentYear();
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

  List<DataAdvModel> lastYearAdvList = [];
  getListOfLastYearPdfAdv() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advPdfData.getListLAstYearAdvPdf();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          lastYearAdvList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv allllllllllllll advvvv {{{{{{{{{{{{{{{{files}}}}}}}}}}}}}}}} بنجاح: ${lastYearAdvList.length} adv");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى JoinGroupResponseModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }

  List<DataAdvModel> favorotePdfList = [];
  getListFavoritePdfAdv() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advPdfData.getListOfFavoritePdfAdv();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          favorotePdfList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv allllllllll favoriiiiiiiiiiiiitee  lllllllllllll بنجاح: ${favorotePdfList.length} adv");
        } catch (e) {
          debugPrint(
              "❌ خطأ أثناء تحويل البيانات إلى JoinGroupResponseModel: $e");
          statusRequest = StatusRequest.failure;
        }
      } else if (response.containsKey("title") &&
          response.containsKey("body")) {
        debugPrint("⚠️ خطأ فاليديشن - تحقق من محتوى الطلب");
        statusRequest = StatusRequest.failure;
      } else {
        debugPrint("❌ استجابة غير متوقعة أو خطأ سيرفر");
        statusRequest = StatusRequest.serverfaliure;
      }
    }
    update();
  }

  @override
  void onInit() {
    carouselController = CarouselSliderController();
    getListOfLatestNewPdfAdv();
    getListOfNewPdfAdvCurrentYear();
    super.onInit();
  }
}
