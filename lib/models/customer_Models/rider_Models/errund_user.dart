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
      this.rateErrund,
      this.onlineRider,
      this.ratingComment,
      this.rating,
      this.phoneNumber});
  String id,
      companyId,
      fName,
      lName,
      email,
      phoneNumber,
      imageUrl,
      address,
      ratingComment;
  bool isRider = false, conditionAccepted = false, rateErrund = false;
  bool onlineRider = false;
  double rating;

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
      rating: json["rating"],
      rateErrund: json["rateErrund"],
      ratingComment: json["ratingComment"],
      address: json["address"]);

  Map<String, dynamic> toMap() => {
        "fName": fName,
        "isRider": isRider,
        "conditionAccepted": conditionAccepted,
        "companyId": companyId,
        "address": address,
        "lName": lName,
        "id": id,
        "email": email,
        "rateErrund": rateErrund,
        "phoneNumber": phoneNumber,
        "onlineRider": onlineRider,
        "ratingComment": ratingComment,
        "rating": rating,
        "imageUrl": imageUrl,
      };
}

String ratingInWords(num rating) {
  if (rating == null) {
    return "";
  } else if (rating <= 2) {
    return "Satisfactory";
  } else if (rating <= 3) {
    return "Responsive";
  } else if (rating <= 4) {
    return "Good";
  } else {
    return "Excellent";
  }
}
