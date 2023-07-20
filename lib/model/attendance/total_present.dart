class TotalPresent {

  late int totalPresent;

  TotalPresent({required this.totalPresent});

  TotalPresent.fromJson(Map<String, dynamic> json) {
    totalPresent = json['total_present'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_present'] = this.totalPresent;
    return data;
  }
}

