class Rider {
  String id, companyId, fName, lName, email, phoneNumber, address;

  static Rider fromMap(data) {
    return Rider()
      ..id = data["id"]
      ..fName = data["fName"]
      ..companyId = data["companyId"]
      ..address = data["address"]
      ..lName = data["lName"]
      ..email = data["email"]
      ..phoneNumber = data["phoneNumber"];
  }

  Map<String, dynamic> toMap() => {
        "fName": fName,
        "companyId": companyId,
        "address": address,
        "lName": lName,
        "id": id,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
