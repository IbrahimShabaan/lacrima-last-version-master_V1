class CustomerModel {
  String? docId;
  String? token;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? image;
  String? companyName;
  String? birthday;
  String? userName;
  String? gender;
  List<dynamic>? interest;

  CustomerModel({
    this.docId,
    this.token,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.image,
    this.companyName,
    this.birthday,
    this.userName,
    this.gender,
    this.interest,
  });

  CustomerModel.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    token = json['token'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    companyName = json['companyName'];
    birthday = json['birthday'];
    userName = json['userName'];
    gender = json['gender'];
    interest = json['interest'];
  }

  Map<String, dynamic> toJson() => {
        'docId': docId,
        'token': token,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': phone,
        'image': image,
        'companyName': companyName,
        'birthday': birthday,
        'userName': userName,
        'gender': gender,
        'interest': interest,
      };
}
