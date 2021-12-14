// ignore_for_file: non_constant_identifier_names

class Service {
  String id,
      riderId,
      customerId,
      billAmount,
      total_amount,
      delivery_address,
      pick_up_address,
      contact_num,
      special_request,
      resturant_name,
      laundry_shop,
      necessary_detail,
      serviceName,
      billType,
      product;
  ServiceStatus status;
  PaymentStatus paymentStatus;
  Map<String, int> route;
  int createdDate;
  bool serviceRate;

  Service({
    this.contact_num,
    this.id,
    this.delivery_address,
    this.laundry_shop,
    this.necessary_detail,
    this.customerId,
    this.riderId,
    this.billAmount,
    this.pick_up_address,
    this.product,
    this.billType,
    this.createdDate,
    this.resturant_name,
    this.serviceRate,
    this.route,
    this.status,
    this.serviceName,
    this.special_request,
    this.total_amount,
    this.paymentStatus,
  });

  factory Service.fromMap(Map<String, dynamic> json) => Service(
      id: json["id"],
      contact_num: json["contact_num"],
      delivery_address: json["delivery_address"],
      laundry_shop: json["laundry_shop"],
      necessary_detail: json["necessary_detail"],
      billAmount: json["billAmount"],
      pick_up_address: json["pick_up_address"],
      product: json["product"],
      resturant_name: json["resturant_name"],
      route: Map<String, int>.from(json["route"]) ?? {},
      special_request: json["special_request"],
      total_amount: json["total_amount"],
      billType: json["bill_payments"],
      serviceName: json["serviceName"],
      status: getServiceStatusType(json["status"]),
      paymentStatus: getPaymentStatusType(json["paymentStatus"]),
      customerId: json["customerId"],
      createdDate: json["createdDate"],
      serviceRate: json["serviceRate"],
      riderId: json["riderId"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "contact_num": contact_num,
        "delivery_address": delivery_address,
        "laundry_shop": laundry_shop,
        "necessary_detail": necessary_detail,
        "billAmount": billAmount,
        "product": product,
        "bill_payments": billType,
        "pick_up_address": pick_up_address,
        "resturant_name": resturant_name,
        "route": route,
        "special_request": special_request,
        "total_amount": total_amount,
        "serviceName": serviceName,
        "customerId": customerId,
        "riderId": riderId,
        "serviceRate": serviceRate,
        "createdDate": createdDate,
        "status": getKeyFromServiceStatusType(status),
        "paymentStatus": getKeyFromPaymentStatus(paymentStatus),
      };
}

enum ServiceStatus { COMPLETED, STARTED, ACTIVE, ABORTED }
ServiceStatus getServiceStatusType(String key) {
  switch (key) {
    case "completed":
      return ServiceStatus.COMPLETED;
    case "started":
      return ServiceStatus.STARTED;
    case "active":
      return ServiceStatus.ACTIVE;
    case "aborted":
      return ServiceStatus.ABORTED;
    default:
      return null;
  }
}

String getKeyFromServiceStatusType(ServiceStatus status) {
  switch (status) {
    case ServiceStatus.COMPLETED:
      return "completed";
    case ServiceStatus.STARTED:
      return "started";
    case ServiceStatus.ACTIVE:
      return "active";
    case ServiceStatus.ABORTED:
      return "aborted";
    default:
      return null;
  }
}

enum PaymentStatus {
  PAID,
  PENDING,
}
PaymentStatus getPaymentStatusType(String key) {
  switch (key) {
    case "paid":
      return PaymentStatus.PAID;
    case "pending":
      return PaymentStatus.PENDING;

    default:
      return null;
  }
}

String getKeyFromPaymentStatus(PaymentStatus status) {
  switch (status) {
    case PaymentStatus.PAID:
      return "paid";
    case PaymentStatus.PENDING:
      return "pending";
    default:
      return null;
  }
}
