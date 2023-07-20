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
  late int status;
  late bool type;
  late ResultCard resultCard;
  late String message;

  ResultModel({required this.status, required this.type, required this.resultCard, required this.message});

  ResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    resultCard = ResultCard.fromJson(json['result_card']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.resultCard != null) {
      data['result_card'] = this.resultCard.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}
