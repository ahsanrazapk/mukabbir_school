class Attendance {
  late String attendanceStatus;
  late String attendanceDate;

  Attendance({required this.attendanceStatus, required this.attendanceDate});

  Attendance.fromJson(Map<String, dynamic> json) {
    attendanceStatus = json['attendance_status'];
    attendanceDate = json['attendance_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attendance_status'] = this.attendanceStatus;
    data['attendance_date'] = this.attendanceDate;
    return data;
  }
}


