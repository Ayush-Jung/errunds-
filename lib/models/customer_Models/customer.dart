class Customer {
  String id, fname, lname, email, phoneNumber, gender, age, token;
  bool isCustomer = false, isAcceptTerms = false;
  static Customer fromMap(data) {
    return Customer()
      ..id = data["id"]
      ..fname = data["fname"]
      ..isAcceptTerms = data["isAcceptTerms"]
      ..lname = data["lname"]
      ..email = data["email"]
      ..isCustomer = data["isCustomer"]
      ..phoneNumber = data["phoneNumber"]
      ..gender = data["gender"]
      ..age = data["age"];
  }

  Map<String, dynamic> toMap() => {
        "lname": lname,
        "fname": fname,
        "isAcceptTerms": isAcceptTerms,
        "id": id,
        "email": email,
        "isCustomer": isCustomer,
        "token": token,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "age": age
      };
}
