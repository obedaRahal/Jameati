import 'dart:io';

import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class FormTowData {
  final Crud crud;
  FormTowData(this.crud);



  postToCreateFormTow(
    String arabicTitle,
    String userSegment,
    String developmentProcedure,
    String librariesAndTools,
    File roadmapFile,
    File workPlanFile,
  ) async {
    var response = await crud.postDataToCreateGroup(
        url: AppLink.createFormTowApi,
        body: {
          "arabic_title": arabicTitle,
          "user_segment": userSegment,
          "development_procedure": developmentProcedure,
          "libraries_and_tools": librariesAndTools,
          "roadmap_file": roadmapFile,
          "work_plan_file": workPlanFile,
        },
        useMultipart: true,
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }
}
