import 'package:mukabbir_schools/model/result/result_card.dart';

/*
class ResultModel {

  late String totalMarks;
  late String totalMarksObt;
  late String percentage;
  late String status;

  late List<Course> coursesList;

  ResultModel({required this.totalMarks, required this.totalMarksObt, required this.percentage, required this.status,
    required this.coursesList});

}
*/

class ResultModel {
  int? status;
  bool? type;
  List<ResultCard>? resultCard;
  String? message;

  ResultModel({this.status, this.type, this.resultCard, this.message});

  ResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    if (json['result_card'] != null) {
      resultCard = <ResultCard>[];
      json['result_card'].forEach((v) {
        resultCard!.add(new ResultCard.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.resultCard != null) {
      data['result_card'] = this.resultCard!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}



