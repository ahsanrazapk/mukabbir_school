class LoginResponse {
  late int status;
  late bool type;
  late String token;
  late String name;
  late String message;

  LoginResponse({required this.status, required this.type, required this.token, required this.name, required this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? 0;
    type = json['type'] ?? false;
    token = json['token'] ?? '';
    name = json['name'] ?? '';
    message = json['message'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    data['token'] = this.token;
    data['name'] = this.name;
    data['message'] = this.message;
    return data;
  }
}
