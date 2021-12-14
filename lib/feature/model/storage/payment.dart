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
    });

    String? id;
    String? name;

    factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}