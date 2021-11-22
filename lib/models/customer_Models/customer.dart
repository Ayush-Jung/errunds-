class AppUser {
  String id, name, email, phoneNumber, gender, age, token;

  static AppUser fromMap(data) {
    return AppUser()
      ..id = data["id"]
      ..token = data["token"]
      ..name = data["name"]
      ..email = data["email"]
      ..phoneNumber = data["phoneNumber"]
      ..gender = data["gender"]
      ..age = data["age"];
  }

  Map<String, dynamic> toMap() => {
        "name": name,
        "id": id,
        "email": email,
        "token": token,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "age": age
      };
}
