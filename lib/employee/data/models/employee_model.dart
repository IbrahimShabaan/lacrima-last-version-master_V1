import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeModel {
  String? empId;
  String? email;
  String? phone;
  String? image;
  String? gender;
  String? section;
  String? address;
  String? empToken;
  String? lastName;
  String? position;
  String? birthday;
  String? userName;
  String? password;
  String? education;
  String? firstName;
  String? hiringDate;
  String? department;
  Timestamp? createdAt;
  double? usedVacations;
  double? totalVacations;
  double? lastYearVacations;

  EmployeeModel({
    this.empId,
    this.email,
    this.phone,
    this.image,
    this.gender,
    this.section,
    this.address,
    this.empToken,
    this.createdAt,
    this.lastName,
    this.position,
    this.birthday,
    this.userName,
    this.password,
    this.firstName,
    this.education,
    this.hiringDate,
    this.department,
    this.usedVacations,
    this.totalVacations,
    this.lastYearVacations,
  });

  EmployeeModel.fromJson(Map<String, dynamic> json) {
    empId = json['empId'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    gender = json['gender'];
    section = json['section'];
    address = json['address'];
    lastName = json['lastName'];
    empToken = json['empToken'];
    position = json['position'];
    birthday = json['birthday'];
    userName = json['userName'];
    password = json['password'];
    createdAt = json['createdAt'];
    education = json['education'];
    firstName = json['firstName'];
    hiringDate = json['hiringDate'];
    department = json['department'];
    usedVacations = json['usedVacations'];
    totalVacations = json['totalVacations'];
    lastYearVacations = json['lastYearVacations'];
  }

  Map<String, dynamic> toJson() => {
        'empId': empId,
        'email': email,
        'phone': phone,
        'image': image,
        'gender': gender,
        'section': section,
        'address': address,
        'empToken': empToken,
        'lastName': lastName,
        'position': position,
        'birthday': birthday,
        'userName': userName,
        'password': password,
        'createdAt': createdAt,
        'education': education,
        'firstName': firstName,
        'hiringDate': hiringDate,
        'department': department,
        'usedVacations': usedVacations,
        'totalVacations': totalVacations,
        'lastYearVacations': lastYearVacations,
      };
}
