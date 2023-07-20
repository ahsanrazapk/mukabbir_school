class ResultDetail {
  late String subjectName;
  late int obtainMarks;
  late int totalMarks;
  int? term;

  ResultDetail({required this.subjectName, required this.obtainMarks, required this.totalMarks, this.term});

  ResultDetail.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    obtainMarks = json['obtain_marks'];
    totalMarks = json['total_marks'];
    term = json['term'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_name'] = this.subjectName;
    data['obtain_marks'] = this.obtainMarks;
    data['total_marks'] = this.totalMarks;
    data['term'] = this.term;
    return data;
  }
}
