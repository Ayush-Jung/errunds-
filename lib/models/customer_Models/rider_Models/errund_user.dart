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
      this.imageUrl,
      this.onlineRider,
      this.phoneNumber});
  String id, companyId, fName, lName, email, phoneNumber, imageUrl, address;
  bool isRider = false, conditionAccepted = false;
  bool onlineRider = false;

  factory ErrundUser.fromMap(Map<String, dynamic> json) => ErrundUser(
        id: json["id"],
        fName: json["fName"],
        conditionAccepted: json["conditionAccepted"],
        lName: json["lName"],
        email: json["email"],
        isRider: json["isRider"],
        phoneNumber: json["phoneNumber"],
        onlineRider: json["onlineRider"],
        companyId: json["companyId"],
        imageUrl: json["imageUrl"],
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
        "onlineRider": onlineRider,
        "imageUrl": imageUrl,
      };
}
