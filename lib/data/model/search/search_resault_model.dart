class SearchReasultModel {
  List<SearchResault>? searchResault;
  int? statusCode;

  SearchReasultModel({this.searchResault, this.statusCode});

  SearchReasultModel.fromJson(Map<String, dynamic> json) {
    if (json['search'] != null) {
      searchResault = <SearchResault>[];
      json['search'].forEach((v) {
        searchResault!.add(new SearchResault.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchResault != null) {
      data['search'] =
          this.searchResault!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class SearchResault {
  int? id;
  String? name;
  String? image;
  String? speciality;
  String? status;

  SearchResault({this.id, this.name, this.image, this.speciality, this.status});

  SearchResault.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    speciality = json['speciality'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['speciality'] = this.speciality;
    data['status'] = this.status;
    return data;
  }
}