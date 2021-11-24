class Rider {
  Rider(
      {this.acceptTerms,
      this.address,
      this.companyId,
      this.email,
      this.fName,
      this.id,
      this.isCustomer,
      this.lName,
      this.phoneNumber});
  String id, companyId, fName, lName, email, phoneNumber, address;
  bool isCustomer = false, acceptTerms = false;

  factory Rider.fromMap(Map<String, dynamic> json) => Rider(
        id: json["id"],
        fName: json["fname"],
        acceptTerms: json["isAcceptTerms"],
        lName: json["lname"],
        email: json["email"],
        isCustomer: json["isCustomer"],
        phoneNumber: json["phoneNumber"],
        address: json["gender"],
        companyId: json["companyId"],
      );

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
