// ignore_for_file: non_constant_identifier_names

class Service {
  String route,
      id,
      payment,
      total_amount,
      delivery_address,
      pick_up_address,
      contact_num,
      special_request,
      resturant_name,
      laundry_shop,
      necessary_detail,
      serviceName,
      product;
  bool expressRate;
  bool lookForRider = false;
  Service({
    this.contact_num,
    this.id,
    this.delivery_address,
    this.expressRate,
    this.laundry_shop,
    this.necessary_detail,
    this.payment,
    this.pick_up_address,
    this.product,
    this.resturant_name,
    this.route,
    this.serviceName,
    this.special_request,
    this.total_amount,
    this.lookForRider,
  });

  factory Service.fromMap(Map<String, dynamic> json) => Service(
        id: json["id"],
        contact_num: json["contact_num"],
        delivery_address: json["delivery_address"],
        expressRate: json["expressRate"],
        laundry_shop: json["laundry_shop"],
        necessary_detail: json["necessary_detail"],
        payment: json["payment"],
        pick_up_address: json["pick_up_address"],
        product: json["product"],
        resturant_name: json["resturant_name"],
        route: json["route"],
        special_request: json["special_request"],
        total_amount: json["total_amount"],
        serviceName: json["serviceName"],
        lookForRider: json["lookForRider"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "contact_num": contact_num,
        "delivery_address": delivery_address,
        "expressRate": expressRate,
        "laundry_shop": laundry_shop,
        "necessary_detail": necessary_detail,
        "payment": payment,
        "product": product,
        "pick_up_address": pick_up_address,
        "resturant_name": resturant_name,
        "route": route,
        "special_request": special_request,
        "total_amount": total_amount,
        "serviceName": serviceName,
        "lookForRider": lookForRider,
      };
}
