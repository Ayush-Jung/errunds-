class Customer {
  Customer({
    this.id,
    this.fname,
    this.email,
    this.isAcceptTerms,
    this.isCustomer,
    this.lName,
    this.phoneNumber,
  });

  String id, fname, lName, email, phoneNumber;
  bool isCustomer = false, isAcceptTerms = false;

  factory Customer.fromMap(Map<String, dynamic> json) => Customer(
        id: json["id"],
        fname: json["fname"],
        isAcceptTerms: json["isAcceptTerms"],
        lName: json["lName"],
        email: json["email"],
        isCustomer: json["isCustomer"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toMap() => {
        "lName": lName,
        "fname": fname,
        "isAcceptTerms": isAcceptTerms,
        "id": id,
        "email": email,
        "isCustomer": isCustomer,
        "phoneNumber": phoneNumber,
      };
}
