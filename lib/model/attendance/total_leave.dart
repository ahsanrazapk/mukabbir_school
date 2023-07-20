class TotalLeave {

  late int totalLeave;

  TotalLeave({required this.totalLeave});

  TotalLeave.fromJson(Map<String, dynamic> json) {
    totalLeave = json['total_leave'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_leave'] = this.totalLeave;
    return data;
  }
}