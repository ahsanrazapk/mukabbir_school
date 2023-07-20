import 'package:mukabbir_schools/model/attendance/attendance.dart';
import 'package:mukabbir_schools/model/attendance/total_absent.dart';
import 'package:mukabbir_schools/model/attendance/total_leave.dart';
import 'package:mukabbir_schools/model/attendance/total_present.dart';

class AttendanceModel {
  late int status;
  late bool type;
  late List<Attendance> attendance;
  late List<TotalPresent> totalPresent;
  late List<TotalAbsent> totalAbsent;
  late List<TotalLeave> totalLeave;
  late String message;

  AttendanceModel(
      {required this.status,
        required this.type,
        required this.attendance,
        required this.totalPresent,
        required this.totalAbsent,
        required this.totalLeave,
        required this.message});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    if (json['attendance'] != null) {
      attendance =[];
      json['attendance'].forEach((v) {
        attendance.add(new Attendance.fromJson(v));
      });
    }
    if (json['total_present'] != null) {
      totalPresent = [];
      json['total_present'].forEach((v) {
        totalPresent.add(new TotalPresent.fromJson(v));
      });
    }
    if (json['total_absent'] != null) {
      totalAbsent = [];
      json['total_absent'].forEach((v) {
        totalAbsent.add(new TotalAbsent.fromJson(v));
      });
    }
    if (json['total_leave'] != null) {
      totalLeave = [];
      json['total_leave'].forEach((v) {
        totalLeave.add(new TotalLeave.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.attendance != null) {
      data['attendance'] = this.attendance.map((v) => v.toJson()).toList();
    }
    if (this.totalPresent != null) {
      data['total_present'] = this.totalPresent.map((v) => v.toJson()).toList();
    }
    if (this.totalAbsent != null) {
      data['total_absent'] = this.totalAbsent.map((v) => v.toJson()).toList();
    }
    if (this.totalLeave != null) {
      data['total_leave'] = this.totalLeave.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

