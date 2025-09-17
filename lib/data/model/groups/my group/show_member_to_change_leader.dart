// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class ShowMemberToChangeLeaderModel {
  List<MembersToChangeLeaderModel>? members;
  int? statusCode;

  ShowMemberToChangeLeaderModel({this.members, this.statusCode});

  ShowMemberToChangeLeaderModel.fromJson(Map<String, dynamic> json) {
    if (json['members'] != null) {
      members = <MembersToChangeLeaderModel>[];
      json['members'].forEach((v) {
        members!.add(new MembersToChangeLeaderModel.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class MembersToChangeLeaderModel {
  int? id;
  int? userId;
  String? name;
  String? profileImage;
  bool? isLeader;

  MembersToChangeLeaderModel({this.id, this.userId, this.name, this.profileImage, this.isLeader});

  MembersToChangeLeaderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    profileImage = json['profile_image'];
    isLeader = json['is_leader'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['is_leader'] = this.isLeader;
    return data;
  }
}