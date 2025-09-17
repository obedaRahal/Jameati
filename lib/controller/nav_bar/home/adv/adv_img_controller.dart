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
import 'package:project_manag_ite/data/datasource/remote/adv/adv_img_data.dart';
import 'package:project_manag_ite/data/model/advvvv/adv_model.dart';

abstract class AdvImgController extends GetxController {}

class AdvImgControllerImp extends AdvImgController {
  RxString selectedScreenPart = "الكل".obs;
  final List<String> screenPart = ["الكل", "السنة الماضية", "المفضلة"];
  RxInt carouselCurrentIndex = 0.obs;
  late CarouselSliderController carouselController = CarouselSliderController();


  StatusRequest statusRequest = StatusRequest.none;
  AdvModel? advModel;
  AdvImgData advImgData = AdvImgData(Get.find());
  RxList<DataAdvModel> latestImgAdvList = <DataAdvModel>[].obs;



  getListOfLatestNewImgAdv() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advImgData.getLatest5AdvImg();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          latestImgAdvList.assignAll(parsed.data ?? []);
          //latestAdvList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv بنجاح: ${latestImgAdvList.length} جروب");
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





  List<DataAdvModel> lastCurrentYearImgAdvList = [];
  getListOfNewImgAdvCurrentYear() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advImgData.getListCurrentYearAdvImg();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          lastCurrentYearImgAdvList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv alllllllllllllllllllllll بنجاح: ${lastCurrentYearImgAdvList.length} جروب");
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
      final either = await advImgData.getToDownloadAdv(advId);
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
    var response = await advImgData.postToAddToFavorite(advId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at registerData: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        getListOfLatestNewImgAdv();
        getListOfNewImgAdvCurrentYear();
        getListFavoriteImgAdv();
        getListOfLatestNewImgAdv();
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
        getListOfLatestNewImgAdv();
        getListOfNewImgAdvCurrentYear();
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
    debugPrint("\\\\\\\\statusRequest at changeLeader  is $statusRequest");
    update();
    var response = await advImgData.delFromFavorite(advId);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      debugPrint("//////im at registerData: handling success response");
      final code = response["statusCode"];

      if (code == 200 || code == 201) {
        debugPrint('  ناجح - code $code');
        getListOfLatestNewImgAdv();
        getListOfNewImgAdvCurrentYear();
        getListFavoriteImgAdv();
        getListOfLatestNewImgAdv();
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
        getListOfLatestNewImgAdv();
        getListOfNewImgAdvCurrentYear();
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
  getListOfLastYearImgAdv() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advImgData.getListLAstYearAdvImg();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          lastYearAdvList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv alllllllllllllllllllllll بنجاح: ${lastYearAdvList.length} adv");
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

  List<DataAdvModel> favoroteImgList = [];
  getListFavoriteImgAdv() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await advImgData.getListOfFavoriteImgAdv();
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response["statusCode"] == 200 || response["statusCode"] == 201) {
        try {
          final parsed = AdvModel.fromJson(response);

          favoroteImgList = parsed.data ?? [];
          debugPrint(
              "✅ تم جلب بيانات advvvv allllllllll favoriiiiiiiiiiiiitee  lllllllllllll بنجاح: ${favoroteImgList.length} adv");
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
    getListOfLatestNewImgAdv();
    getListOfNewImgAdvCurrentYear();
    super.onInit();
  }
}
