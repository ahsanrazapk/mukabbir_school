import 'package:mukabbir_schools/model/workbook/subjects_detail.dart';

class Worksheet {
  late String file;
  late String date;
  late List<SubjectsDetail> subjectsDetail;
  late int fileExist;

  Worksheet({required this.file, required this.date, required this.subjectsDetail, required this.fileExist});

  Worksheet.fromJson(Map<String, dynamic> json) {
    file = json['file'];
    date = json['date'];
    if (json['subjects_detail'] != null) {
      subjectsDetail = [];
      json['subjects_detail'].forEach((v) {
        subjectsDetail.add(new SubjectsDetail.fromJson(v));
      });
    }
    fileExist = json['file_exist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file'] = this.file;
    data['date'] = this.date;
    data['subjects_detail'] = this.subjectsDetail.map((v) => v.toJson()).toList();
    data['file_exist'] = this.fileExist;
    return data;
  }
}
