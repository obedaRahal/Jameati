
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class AdvPdfData {
  final Crud crud;
  AdvPdfData(this.crud);

  Future<dynamic> getLatest5AdvPdf() async {
    var response = await crud.getData(
        url: AppLink.getLatest5AdvPdfApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getListCurrentYearAdvPdf() async {
    var response = await crud.getData(
        url: AppLink.getListCurrentYearAdvPdfApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }


  Future<dynamic> getListLAstYearAdvPdf() async {
    var response = await crud.getData(
        url: AppLink.getListLastYearAdvPdfApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getListOfFavoritePdfAdv() async {
    var response = await crud.getData(
        url: AppLink.getListOfFavoriteAdvPdfApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }




  Future<Either<StatusRequest, http.Response>> getToDownloadAdv(
      int advId) async {
    return await crud.getBytes(
      url: "${AppLink.getToDownloadAdvApi}/$advId/download",
      headers: getAuthHeaders(), 
    );
  }

  Future<dynamic> postToAddToFavorite(int advId) async {
    var response = await crud.postData(
        url: "${AppLink.postToAddToFavApi}/$advId",
        body: {},
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }


  Future<dynamic> delFromFavorite(int advId) async {
    var response = await crud.deleteData(
        url: "${AppLink.deleteToRemoveFavApi}/$advId",
        body: {},
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }


}
