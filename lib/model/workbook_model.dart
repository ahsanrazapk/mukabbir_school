import 'package:mukabbir_schools/model/workbook/worksheet.dart';

class WorkBookModel {

  late int status;
  late bool type;
  late List<Worksheet> worksheet;
  late String message;

  WorkBookModel({required this.status, required this.type, required this.worksheet, required this.message});

  WorkBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    if (json['worksheet'] != null) {
      worksheet = [];
      json['worksheet'].forEach((v) {
        worksheet.add(new Worksheet.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.worksheet != null) {
      data['worksheet'] = this.worksheet.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}



