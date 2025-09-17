import 'package:project_manag_ite/core/class/crud.dart';
import 'package:project_manag_ite/core/functions/get_token.dart';
import 'package:project_manag_ite/link_api.dart';

class SearchData {
  final Crud crud;
  SearchData(this.crud);

  Future<dynamic> getSearchHistory() async {
    var response = await crud.getData(
        url: AppLink.getListOfSearchHistoryApi, headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  Future<dynamic> delFromSearch(int searchId) async {
    var response = await crud.deleteData(
        url: "${AppLink.deleteSearchItemApi}/$searchId",
        body: {},
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }

  postToSearch(
    String search,
  ) async {
    var response = await crud.postData(
        url: AppLink.searchApi,
        body: {
          "search": search,
        },
        useMultipart: true,
        headers: getAuthHeaders());

    return response.fold((l) => l, (r) => r);
  }
}
