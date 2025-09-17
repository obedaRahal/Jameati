// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class FormDatesModel {
  Form1? form1;
  Form1? form2;
  int? statusCode;

  FormDatesModel({this.form1, this.form2, this.statusCode});

  FormDatesModel.fromJson(Map<String, dynamic> json) {
    form1 = json['form1'] != null ? new Form1.fromJson(json['form1']) : null;
    form2 = json['form2'] != null ? new Form1.fromJson(json['form2']) : null;

    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.form1 != null) {
      data['form1'] = this.form1!.toJson();
    }
    if (this.form2 != null) {
      data['form2'] = this.form2!.toJson();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}


class Form1 {
  String? start;
  String? end;
  String? remaining;

  // ✅ الحقول المحسوبة الجديدة
  late final String remainingNumber;
  late final String remainingUnit;

  Form1({this.start, this.end, this.remaining}) {
    _parseRemaining(); // 🟢 معالجة فورية عند الإنشاء
  }

  Form1.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    remaining = json['remaining'];
    _parseRemaining(); // 🟢 المعالجة عند التحميل
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    data['remaining'] = remaining;
    return data;
  }

  // ✅ الدالة الخاصة للتحليل
  void _parseRemaining() {
    final value = remaining?.trim() ?? "";
    final regex = RegExp(r'^(\d+)(\D+)$');
    final match = regex.firstMatch(value);

    if (match != null) {
      remainingNumber = match.group(1) ?? "0";
      remainingUnit = match.group(2)?.trim() ?? "";
    } else {
      remainingNumber = "0";
      remainingUnit = "";
    }
  }
}
