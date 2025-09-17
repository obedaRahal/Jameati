import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_manag_ite/core/class/status_request.dart';
import 'package:project_manag_ite/core/functions/handling_data.dart';
import 'package:project_manag_ite/data/datasource/remote/search/search_data.dart';
import 'package:project_manag_ite/data/model/search/search_history_model.dart';
import 'package:project_manag_ite/data/model/search/search_resault_model.dart';

abstract class SearchController extends GetxController {}

class SearchControllerImp extends SearchController {
  late TextEditingController searchForAnyThing;
  RxString query = ''.obs;

  StatusRequest statusRequest = StatusRequest.none;

  RxList<SearchResault> searchReasultList = <SearchResault>[].obs;

  RxList<SearchHistory> searchHistoryList = <SearchHistory>[].obs;

  final SearchData searchData = SearchData(Get.find());

  final String searchSectionId = "searchSection";
  final String historySectionId = "searchHistory";

  @override
  void onInit() {
    searchForAnyThing = TextEditingController();

    searchForAnyThing.addListener(() {
      query.value = searchForAnyThing.text;
    });

    debounce<String>(
      query,
      (_) => _onQueryChanged(),
      time: const Duration(milliseconds: 400),
    );

    getListOfSearchHistory();

    super.onInit();
  }

  @override
  void dispose() {
    searchForAnyThing.dispose();
    super.dispose();
  }

  Future<void> _onQueryChanged() async {
    final q = query.value.trim();
    if (q.isEmpty) {
      searchReasultList.clear();
      update([searchSectionId]);
      return;
    }
    await performSearch(q);
  }

  Future<void> performSearch(String q) async {
    try {
      statusRequest = StatusRequest.loading;
      update([searchSectionId]);

      final response = await searchData.postToSearch(q); 
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        final code = response["statusCode"] as int? ?? 200;
        if (code == 200 || code == 201) {
          final model = SearchReasultModel.fromJson(response as Map<String, dynamic>);
          final list = model.searchResault ?? <SearchResault>[];
          searchReasultList.assignAll(list);
          getListOfSearchHistory();
        } else {
          searchReasultList.clear();
          statusRequest = StatusRequest.failure;
        }
      } else {
        searchReasultList.clear();
      }
    } catch (e) {
      searchReasultList.clear();
      statusRequest = StatusRequest.failure;
    } finally {
      update([searchSectionId]);
    }
  }

  // ✅ جلب السجل
  Future<void> getListOfSearchHistory() async {
    try {
      statusRequest = StatusRequest.loading;
      update([historySectionId]);

      final response = await searchData.getSearchHistory();
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        final code = response["statusCode"] as int? ?? 200;
        if (code == 200 || code == 201) {
          final model = SearchHistoryModel.fromJson(response as Map<String, dynamic>);
          searchHistoryList.assignAll(model.searchHistory ?? <SearchHistory>[]);
        } else {
          searchHistoryList.clear();
          statusRequest = StatusRequest.failure;
        }
      } else {
        searchHistoryList.clear();
      }
    } catch (_) {
      searchHistoryList.clear();
      statusRequest = StatusRequest.failure;
    } finally {
      update([historySectionId]);
    }
  }

  // ✅ حذف عنصر من السجل (ثمّ حدّث القائمة محليًا أو أعد الجلب)
  Future<void> deleteSearchItem(int searchId) async {
    try {
      statusRequest = StatusRequest.loading;
      update([historySectionId]);

      final response = await searchData.delFromSearch(searchId);
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        final code = response["statusCode"] as int? ?? 200;
        if (code == 200 || code == 201) {
          // إمّا تحدّث السجل من الاستجابة إن أعادت قائمة:
          // final model = SearchHistoryModel.fromJson(response);
          // searchHistoryList.assignAll(model.searchHistory ?? []);
          // أو ببساطة احذف محليًا:
          searchHistoryList.removeWhere((e) => e.id == searchId);
        } else {
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (_) {
      statusRequest = StatusRequest.failure;
    } finally {
      update([historySectionId]);
    }
  }
}
