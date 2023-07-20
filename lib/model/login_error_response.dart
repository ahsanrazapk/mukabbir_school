class LoginErrorResponse {
  late int status;
  late bool type;
  late String message;

  LoginErrorResponse({required this.status, required this.type, required this.message});

  LoginErrorResponse.fromJson(Map<String, dynamic> json) {
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
