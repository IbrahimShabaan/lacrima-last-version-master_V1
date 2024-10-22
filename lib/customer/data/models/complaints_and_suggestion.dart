import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintsAndSuggestionModel {
  String? id;
  String? type;
  String? date;
  String? email;
  String? content;
  String? fullName;
  Timestamp? createdAt;

  ComplaintsAndSuggestionModel({
    this.id,
    this.type,
    this.date,
    this.email,
    this.content,
    this.fullName,
    this.createdAt,
  });

  ComplaintsAndSuggestionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    date = json['date'];
    email = json['email'];
    content = json['content'];
    fullName = json['fullName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'date': date,
        'email': email,
        'content': content,
        'fullName': fullName,
        'createdAt': createdAt,
      };
}
