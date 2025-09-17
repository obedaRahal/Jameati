import 'package:dartz/dartz.dart';
import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';
import 'package:http/http.dart' as http;

class AdvImgData {
  final Crud crud;
  AdvImgData(this.crud);

  Future<dynamic> getLatest5AdvImg() async {
    var response = await crud.getData(
        url: AppLink.getLatest5AdvImgApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> getListCurrentYearAdvImg() async {
    var response = await crud.getData(
        url: AppLink.getListCurrentYearAdvImgApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }


  Future<dynamic> getListLAstYearAdvImg() async {
    var response = await crud.getData(
        url: AppLink.getListLastYearAdvImgApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }
  Future<dynamic> getListOfFavoriteImgAdv() async {
    var response = await crud.getData(
        url: AppLink.getListOfFavoriteAdvImgApi, headers: getAuthHeaders());

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
