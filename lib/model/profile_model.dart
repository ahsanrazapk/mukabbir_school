import 'package:mukabbir_schools/model/profile_detail.dart';

class ProfileModel {
  late int status;
  late bool type;
  late ProfileDetail profileDetail;
  late String message;

  ProfileModel({required this.status, required this.type, required this.profileDetail, required this.message});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    profileDetail = (json['profile_detail'] != null
        ? new ProfileDetail.fromJson(json['profile_detail'])
        : null)!;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.profileDetail != null) {
      data['profile_detail'] = this.profileDetail.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

