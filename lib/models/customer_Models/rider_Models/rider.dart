class Rider {
  String id, companyId, fName, lName, email, phoneNumber, address;
  bool isCustomer = false, acceptTerms = false;
  static Rider fromMap(data) {
    return Rider()
      ..id = data["id"]
      ..isCustomer = data["isCustomer"]
      ..acceptTerms = data["acceptTerms"]
      ..fName = data["fName"]
      ..companyId = data["companyId"]
      ..address = data["address"]
      ..lName = data["lName"]
      ..email = data["email"]
      ..phoneNumber = data["phoneNumber"];
  }

  Map<String, dynamic> toMap() => {
        "fName": fName,
        "isCustomer": isCustomer,
        "acceptTerms": acceptTerms,
        "companyId": companyId,
        "address": address,
        "lName": lName,
        "id": id,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
