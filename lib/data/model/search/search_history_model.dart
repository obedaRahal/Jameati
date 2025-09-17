class SearchHistoryModel {
  List<SearchHistory>? searchHistory;
  int? statusCode;

  SearchHistoryModel({this.searchHistory, this.statusCode});

  SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['searchHistory'] != null) {
      searchHistory = <SearchHistory>[];
      json['searchHistory'].forEach((v) {
        searchHistory!.add(new SearchHistory.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchHistory != null) {
      data['searchHistory'] =
          this.searchHistory!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class SearchHistory {
  int? id;
  String? query;

  SearchHistory({this.id, this.query});

  SearchHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    query = json['query'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['query'] = this.query;
    return data;
  }
}