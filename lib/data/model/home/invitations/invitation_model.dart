// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class InvitationModel {
  List<Invitations>? invitations;
  int? statusCode;

  InvitationModel({this.invitations, this.statusCode});

  InvitationModel.fromJson(Map<String, dynamic> json) {
    if (json['invitations'] != null) {
      invitations = <Invitations>[];
      json['invitations'].forEach((v) {
        invitations!.add(new Invitations.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.invitations != null) {
      data['invitations'] = this.invitations!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class Invitations {
  int? id;
  int? groupId;
  int? invitedUserId;
  int? invitedByUserId;
  String? status;
  Group? group;

  Invitations(
      {this.id,
      this.groupId,
      this.invitedUserId,
      this.invitedByUserId,
      this.status,
      this.group});

  Invitations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['group_id'];
    invitedUserId = json['invited_user_id'];
    invitedByUserId = json['invited_by_user_id'];
    status = json['status'];
    group = json['group'] != null ? new Group.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['group_id'] = this.groupId;
    data['invited_user_id'] = this.invitedUserId;
    data['invited_by_user_id'] = this.invitedByUserId;
    data['status'] = this.status;
    if (this.group != null) {
      data['group'] = this.group!.toJson();
    }
    return data;
  }
}

class Group {
  int? id;
  String? name;
  List<String>? specialityNeeded;
  String? image;

  Group({this.id, this.name, this.specialityNeeded, this.image});

  Group.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    specialityNeeded = json['speciality_needed'].cast<String>();
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['speciality_needed'] = this.specialityNeeded;
    data['image'] = this.image;
    return data;
  }
}