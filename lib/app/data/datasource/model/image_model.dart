import 'dart:convert';

import 'package:heart_usb/app/data/domain/entities/image_entity.dart';

ImageModel imageFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
    String image;

    ImageEntity toEntity() {
    return ImageEntity(
      image: image
    );
  }

    ImageModel({
        required this.image,
    });

    factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
    };
}