class ImageData {
  late int id;
  late String image;
  late String uploadedBy;
  late String uploadedOn;

  ImageData({required this.id, required this.image, required this.uploadedBy, required this.uploadedOn});

  ImageData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    uploadedBy = json['uploaded_by'];
    uploadedOn = json['uploaded_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['uploaded_by'] = this.uploadedBy;
    data['uploaded_on'] = this.uploadedOn;
    return data;
  }
}
