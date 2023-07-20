class ProfileDetail {
  late String name;
  late String username;
  late String fatherName;
  late String contact;
  late String ageGroup;
  late String dateOfBirth;
  late String joiningDate;
  late String profileImg;
  late String campus;
  late String grade;
  late String section;
  late String sessionName;

  ProfileDetail(
      {required this.name,
        required this.username,
        required this.fatherName,
        required this.contact,
        required this.ageGroup,
        required this.dateOfBirth,
        required this.joiningDate,
        required this.profileImg,
        required this.campus,
        required this.grade,
        required this.section,
        required this.sessionName});

  ProfileDetail.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    fatherName = json['father_name'];
    contact = json['contact'];
    ageGroup = json['age_group'];
    dateOfBirth = json['date_of_birth'];
    joiningDate = json['joining_date'];
    profileImg = json['profile_img'];
    campus = json['campus'];
    grade = json['grade'];
    section = json['section'];
    sessionName = json['session_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['username'] = this.username;
    data['father_name'] = this.fatherName;
    data['contact'] = this.contact;
    data['age_group'] = this.ageGroup;
    data['date_of_birth'] = this.dateOfBirth;
    data['joining_date'] = this.joiningDate;
    data['profile_img'] = this.profileImg;
    data['campus'] = this.campus;
    data['grade'] = this.grade;
    data['section'] = this.section;
    data['session_name'] = this.sessionName;
    return data;
  }
}
