class SubjectsDetail {

  late String subject;
  late String detail;

  SubjectsDetail({required this.subject, required this.detail});

  SubjectsDetail.fromJson(Map<String, dynamic> json) {
    subject = json['subject'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject'] = this.subject;
    data['detail'] = this.detail;
    return data;
  }
}
