// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class JoinToGroupItemModel {
  List<Groups>? groups;
  int? statusCode;

  JoinToGroupItemModel({this.groups, this.statusCode});

  JoinToGroupItemModel.fromJson(Map<String, dynamic> json) {
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(new Groups.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.groups != null) {
      data['groups'] = this.groups!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Groups {
  int? id;
  String? name;
  String? image;
  List<String>? specialitiesNeeded;
  int? membersCount;
  bool? hasRequestedJoin;

  Groups(
      {this.id,
      this.name,
      this.image,
      this.specialitiesNeeded,
      this.membersCount, 
      this.hasRequestedJoin
      });

  Groups.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    specialitiesNeeded = json['specialities_needed'].cast<String>();
    membersCount = json['members_count'];
    hasRequestedJoin = json['has_requested_join'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['specialities_needed'] = this.specialitiesNeeded;
    data['members_count'] = this.membersCount;
    data['has_requested_join'] = this.hasRequestedJoin;
    return data;
  }
}