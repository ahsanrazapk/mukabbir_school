import 'package:mukabbir_schools/model/image_data.dart';

/*
class GalleryModel {

  final String image;
  GalleryModel({required this.image});

}*/



class GalleryModel {
  late int status;
  late bool type;
  late List<ImageData> images;
  late String message;

  GalleryModel({required this.status, required this.type, required this.images, required this.message});

  GalleryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(new ImageData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

