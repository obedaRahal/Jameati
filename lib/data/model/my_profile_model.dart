// ignore_for_file: unnecessary_new, prefer_collection_literals, unnecessary_this

class MyProfileModel {
  MyProfileInfoModel? user;

  MyProfileModel({this.user});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new MyProfileInfoModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class MyProfileInfoModel {
  int? id;
  String? name;
  String? email;
  String? universityNumber;
  String? role;
  String? governorate;
  String? phoneNumber;
  String? birthDate;
  String? studentSpeciality;
  String? studentStatus;
  String? profileImage;
  String? createdAt;

  MyProfileInfoModel(
      {this.id,
      this.name,
      this.email,
      this.universityNumber,
      this.role,
      this.governorate,
      this.phoneNumber,
      this.birthDate,
      this.studentSpeciality,
      this.studentStatus,
      this.profileImage,
      this.createdAt});

  MyProfileInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    universityNumber = json['university_number'];
    role = json['role'];
    governorate = json['governorate'];
    phoneNumber = json['phone_number'];
    birthDate = json['birth_date'];
    studentSpeciality = json['student_speciality'];
    studentStatus = json['student_status'];
    profileImage = json['profile_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['university_number'] = this.universityNumber;
    data['role'] = this.role;
    data['governorate'] = this.governorate;
    data['phone_number'] = this.phoneNumber;
    data['birth_date'] = this.birthDate;
    data['student_speciality'] = this.studentSpeciality;
    data['student_status'] = this.studentStatus;
    data['profile_image'] = this.profileImage;
    data['created_at'] = this.createdAt;
    return data;
  }
}