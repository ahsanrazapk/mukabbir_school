class ProfileImgUpdate {

  late int status;
  late bool type;
  late String message;

  ProfileImgUpdate({required this.status, required this.type, required this.message});

  ProfileImgUpdate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}
