import 'package:cloud_firestore/cloud_firestore.dart';

class RequestsModel {
  String? type;
  String? empId;
  String? status;
  String? empToken;
  String? requestId;
  String? empLastName;
  String? requestType;
  String? endDateTime;
  String? empFirstName;
  Timestamp? createdAt;
  String? startDateTime;

  RequestsModel({
    this.type,
    this.empId,
    this.status,
    this.empToken,
    this.createdAt,
    this.requestId,
    this.empLastName,
    this.requestType,
    this.endDateTime,
    this.empFirstName,
    this.startDateTime,
  });

  RequestsModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    empId = json['empId'];
    status = json['status'];
    empToken = json['empToken'];
    createdAt = json['createdAt'];
    requestId = json['requestId'];
    endDateTime = json['endDateTime'];
    empLastName = json['empLastName'];
    requestType = json['requestType'];
    empFirstName = json['empFirstName'];
    startDateTime = json['startDateTime'];
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'empId': empId,
        'status': status,
        'empToken': empToken,
        'createdAt': createdAt,
        'requestId': requestId,
        'endDateTime': endDateTime,
        'empLastName': empLastName,
        'requestType': requestType,
        'empFirstName': empFirstName,
        'startDateTime': startDateTime,
      };
}
