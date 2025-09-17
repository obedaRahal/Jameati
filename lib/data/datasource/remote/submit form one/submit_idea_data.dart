import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class SubmitIdeaData {
  final Crud crud;
  SubmitIdeaData(this.crud);

  Future<dynamic> getMember() async {
    var response = await crud.getData(
        url: AppLink.getMemberForFormOneApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getDoctors() async {
    var response = await crud.getData(
        url: AppLink.getDoctorForFormOneApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  postToCreateFormOne(
    String userId,
    String arabicTitle,
    String englishTitle,
    String description,
    String projectScope,
    String targetedSector,
    String sectorClassification,
    String stakeholders,
  ) async {
    var response = await crud.postData(
        url: AppLink.createFormOneApi,
        body: {
          "user_id": userId,
          "arabic_title": arabicTitle,
          "english_title": englishTitle,
          "description": description,
          "project_scope": projectScope,
          "targeted_sector": targetedSector,
          "sector_classification": sectorClassification,
          "stakeholders": stakeholders,
        },
        useMultipart: true,
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }
}
