import 'package:get/get.dart';
import 'package:project_manag_ite/core/services/services.dart';

Map<String, String> getAuthHeaders() {
  final token = Get.find<MyServices>().sharedPreferences.getString("token");
  return {
    //"Content-Type": "application/json",
    if (token != null) "Authorization": "Bearer $token",
  };
}
