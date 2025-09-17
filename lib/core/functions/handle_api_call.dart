// import 'package:get/get.dart';
// import 'package:project_manag_ite/core/class/status_request.dart';
// import 'package:project_manag_ite/core/functions/validation.dart';

// Future<void> handleApiCall({
//   required Future<dynamic> Function() apiCall,
//   required Function onSuccess,
//   required Function(StatusRequest) setStatus,
//   String successMessage = "تم بنجاح",
//   String? successTitle,
//   bool navigateOnSuccess = false,
//   String? successRoute,

//   /// 🆕 تنفيذ خاص لحالات مثل `verify == false`
//   Function(Map response)? customErrorHandler,
// }) async {
//   setStatus(StatusRequest.loading);

//   final response = await apiCall();
//   final StatusRequest status = _handlingData(response);
//   setStatus(status);

//   if (status == StatusRequest.success) {
//     final code = response["statusCode"];

//     // ✅ نجاح فعلي
//     if (code == 200 || code == 201) {
//       showCustomSnackbar(
//         title: successTitle ?? "نجاح",
//         message: response["body"] ?? successMessage,
//         isSuccess: true,
//       );

//       if (navigateOnSuccess && successRoute != null) {
//         Get.toNamed(successRoute);
//       }

//       onSuccess();
//     }

//     // ⚠️ معالجة مخصصة إن لزم
//     else if (customErrorHandler != null) {
//       customErrorHandler(response);
//       setStatus(StatusRequest.failure);
//     }

//     // ⚠️ رسالة خطأ قياسية من السيرفر
//     else if (response.containsKey("title") && response.containsKey("body")) {
//       showCustomSnackbar(
//         title: response["title"] ?? "خطأ",
//         message: response["body"] ?? "تحقق من البيانات المدخلة",
//         isSuccess: false,
//       );
//       setStatus(StatusRequest.failure);
//     }

//     // ❌ استجابة غير مفهومة
//     else {
//       showCustomSnackbar(
//         title: "خطأ غير متوقع",
//         message: "حدث خلل في الاتصال، حاول لاحقًا",
//         isSuccess: false,
//       );
//       setStatus(StatusRequest.serverfaliure);
//     }
//   }

//   // ❌ فشل الاتصال
//   else {
//     showCustomSnackbar(
//       title: "فشل الاتصال",
//       message: "تأكد من اتصالك بالإنترنت",
//       isSuccess: false,
//     );
//   }
// }

// /// ✅ دالة محلية لتحليل استجابة `Either`
// StatusRequest _handlingData(dynamic response) {
//   if (response is StatusRequest) {
//     return response;
//   }
//   return StatusRequest.success;
// }
