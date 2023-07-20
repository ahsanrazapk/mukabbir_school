class TotalAbsent {

  late int totalAbsent;

  TotalAbsent({required this.totalAbsent});

  TotalAbsent.fromJson(Map<String, dynamic> json) {
    totalAbsent = json['total_absent'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_absent'] = this.totalAbsent;
    return data;
  }
}
