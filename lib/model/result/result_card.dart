import 'package:mukabbir_schools/model/result/result_detail.dart';

class ResultCard {
  late String studentName;
  late String campus;
  late String grade;
  late String section;
  late String sessionName;
  late String term;
  late List<ResultDetail> resultDetail;

  ResultCard(
      {required this.studentName,
      required this.campus,
      required this.grade,
      required this.section,
      required this.sessionName,
      required this.term,
      required this.resultDetail});

  ResultCard.fromJson(Map<String, dynamic> json) {
    studentName = json['student_name'];
    campus = json['campus'];
    grade = json['grade'];
    section = json['section'];
    sessionName = json['session_name'];
    term = json['term'].toString();
    if (json['result_detail'] != null) {
      resultDetail = [];
      json['result_detail'].forEach((v) {
        resultDetail.add(new ResultDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_name'] = this.studentName;
    data['campus'] = this.campus;
    data['grade'] = this.grade;
    data['section'] = this.section;
    data['session_name'] = this.sessionName;
    data['term'] = this.term;
    data['result_detail'] = this.resultDetail.map((v) => v.toJson()).toList();
    return data;
  }
}
