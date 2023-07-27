
class ResultCard {
  String? subjectName;
  int? subjectId;
  ObtainedMarks? obtainedMarks;
  ObtainedMarks? obtainedTerm;
  int? totalMarks;

  ResultCard({this.subjectName, this.subjectId, this.obtainedMarks, this.obtainedTerm, this.totalMarks});

  ResultCard.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    subjectId = json['subject_id'];
    obtainedMarks = json['obtained_marks'] != null ? new ObtainedMarks.fromJson(json['obtained_marks']) : null;
    obtainedTerm = json['obtained_term'] != null ? new ObtainedMarks.fromJson(json['obtained_term']) : null;
    totalMarks = json['total_marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_name'] = this.subjectName;
    data['subject_id'] = this.subjectId;
    if (this.obtainedMarks != null) {
      data['obtained_marks'] = this.obtainedMarks!.toJson();
    }
    if (this.obtainedTerm != null) {
      data['obtained_term'] = this.obtainedTerm!.toJson();
    }
    data['total_marks'] = this.totalMarks;
    return data;
  }
}

class ObtainedMarks {
  TermWithMarks? i11;
  TermWithMarks? i12;
  TermWithMarks? i13;
  TermWithMarks? i14;
  TermWithMarks? i15;
  TermWithMarks? i16;
  TermWithMarks? i17;
  TermWithMarks? i18;
  TermWithMarks? i19;
  TermWithMarks? i20;

  ObtainedMarks({this.i11, this.i12, this.i13, this.i14, this.i15, this.i16, this.i17, this.i18, this.i19, this.i20});

  Map<String, dynamic> toJson() {
    return {
      '11': this.i11,
      '12': this.i12,
      '13': this.i13,
      '14': this.i14,
      '15': this.i15,
      '16': this.i16,
      '17': this.i17,
      '18': this.i18,
      '19': this.i19,
      '20': this.i20,
    };
  }

  factory ObtainedMarks.fromJson(Map<String, dynamic> map) {
    return ObtainedMarks(
      i11: TermWithMarks(map['11'], '11'),
      i12: TermWithMarks(map['12'], '12'),
      i13: TermWithMarks(map['13'], '13'),
      i14: TermWithMarks(map['14'], '14'),
      i15: TermWithMarks(map['15'], '15'),
      i16: TermWithMarks(map['16'], '16'),
      i17: TermWithMarks(map['17'], '17'),
      i18: TermWithMarks(map['18'], '18'),
      i19: TermWithMarks(map['19'], '19'),
      i20: TermWithMarks(map['20'], '20'),
    );
  }
}

class TermWithMarks {
  int? marks;
  String? term;

  TermWithMarks(this.marks, this.term);
}
