class Customer {
  String id, fname, lname, email, phoneNumber, gender, age, token;

  static Customer fromMap(data) {
    return Customer()
      ..id = data["id"]
      ..token = data["token"]
      ..fname = data["fname"]
      ..lname = data["lname"]
      ..email = data["email"]
      ..phoneNumber = data["phoneNumber"]
      ..gender = data["gender"]
      ..age = data["age"];
  }

  Map<String, dynamic> toMap() => {
        "lname": lname,
        "fname": fname,
        "id": id,
        "email": email,
        "token": token,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "age": age
      };
}
