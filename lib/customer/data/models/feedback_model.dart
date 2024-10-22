class FeedbackModel {
  String? id;
  String? date;
  String? email;
  String? content;
  String? lastName;
  String? firstName;

  FeedbackModel({
    this.id,
    this.date,
    this.email,
    this.content,
    this.lastName,
    this.firstName,
  });

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    email = json['email'];
    content = json['content'];
    lastName = json['lastName'];
    firstName = json['firstName'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'email': email,
        'content': content,
        'lastName': lastName,
        'firstName': firstName,
      };
}
