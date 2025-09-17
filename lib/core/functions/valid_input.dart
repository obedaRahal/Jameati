import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == "username") {
    if (!GetUtils.isUsername(val)) {
      return "اسم غير صالح";
    }
  }
  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "ايميل غير صالح";
    }
  }
  if (type == "number") {
    if (!GetUtils.isNumericOnly(val)) {
      return "رقم غير صالح";
    }
  }

  if (val.isEmpty){
    return "القيمة لا يمكن ان تكون فارغة";
  }
  if (val.length < min){
    return "القيمة لا يمكن ان تكون أقل من $min";
  }
  if (val.length > max){
    return "القيمة لا يمكن ان تكون أكبر من $max";
  }
}
