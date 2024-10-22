class JobModel {
  String? id;
  String? cv;
  String? name;
  String? title;
  String? phone;
  String? email;
  String? yourJob;
  String? date;

  JobModel({
    this.id,
    this.cv,
    this.date,
    this.name,
    this.title,
    this.phone,
    this.email,
    this.yourJob,
  });

  JobModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cv = json['cv'];
    date = json['date'];
    name = json['name'];
    title = json['title'];
    phone = json['phone'];
    email = json['email'];
    yourJob = json['yourJob'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cv': cv,
        'date': date,
        'name': name,
        'title': title,
        'phone': phone,
        'email': email,
        'yourJob': yourJob,
      };
}
