class Payment {
    Payment({
        this.paymentMethod,
    });

    List<PaymentMethod>? paymentMethod;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        paymentMethod: List<PaymentMethod>.from(json["payment_method"].map((x) => PaymentMethod.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "payment_method": List<dynamic>.from(paymentMethod!.map((x) => x.toJson())),
    };
}

class PaymentMethod {
    PaymentMethod({
        this.id,
        this.name,
        this.image
    });

    String? id;
    String? name;
    String? image;

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image" : image,
        "name": name,
    };

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentMethod &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}