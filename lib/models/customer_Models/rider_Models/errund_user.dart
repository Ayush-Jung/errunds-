class ErrundUser {
  ErrundUser(
      {this.conditionAccepted,
      this.address,
      this.companyId,
      this.email,
      this.fName,
      this.id,
      this.isRider,
      this.lName,
      this.phoneNumber});
  String id, companyId, fName, lName, email, phoneNumber, address;
  bool isRider = false, conditionAccepted = false;

  factory ErrundUser.fromMap(Map<String, dynamic> json) => ErrundUser(
        id: json["id"],
        fName: json["fname"],
        conditionAccepted: json["isAcceptTerms"],
        lName: json["lname"],
        email: json["email"],
        isRider: json["isCustomer"],
        phoneNumber: json["phoneNumber"],
        address: json["gender"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toMap() => {
        "fName": fName,
        "isCustomer": isRider,
        "acceptTerms": conditionAccepted,
        "companyId": companyId,
        "address": address,
        "lName": lName,
        "id": id,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
