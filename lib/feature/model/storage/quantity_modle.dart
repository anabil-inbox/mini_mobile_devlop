class Quantity {
    Quantity({
        this.itemCode,
        this.itemName,
        this.itemNameTr,
        this.quantity,
    });

    String? itemCode;
    String? itemName;
    String? itemNameTr;
    double? quantity;

    factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        itemCode: json["item_code"] == null ? null : json["item_code"],
        itemName: json["item_name"]  == null ? null : json["item_name"],
        itemNameTr: json["item_name_tr"]  == null ? null : json["item_name_tr"],
        quantity: json["quantity"]  == null ? null : json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "item_code": itemCode,
        "item_name": itemName,
        "item_name_tr": itemNameTr,
        "quantity": quantity,
    };
}