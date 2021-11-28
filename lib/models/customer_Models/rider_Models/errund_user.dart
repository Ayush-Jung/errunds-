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
        fName: json["fName"],
        conditionAccepted: json["conditionAccepted"],
        lName: json["lName"],
        email: json["email"],
        isRider: json["isRider"],
        phoneNumber: json["phoneNumber"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toMap() => {
        "fName": fName,
        "isRider": isRider,
        "conditionAccepted": conditionAccepted,
        "companyId": companyId,
        "address": address,
        "lName": lName,
        "id": id,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
