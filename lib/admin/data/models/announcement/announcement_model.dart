import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementModel {
  String? id;
  String? date;
  String? title;
  String? image;
  String? description;
  Timestamp? createdAt;
  AnnouncementModel({
    this.id,
    this.date,
    this.title,
    this.image,
    this.createdAt,
    this.description,
  });

  AnnouncementModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    title = json['title'];
    image = json['image'];
    createdAt = json['createdAt'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'title': title,
        'image': image,
        'createdAt': createdAt,
        'description': description,
      };
}
