class Quantity {
    Quantity({
        this.itemCode,
        this.itemName,
        this.itemNameTr,
        this.availableQuantity,
        this.orderedQuantity,
        this.quantityDifference,
        this.quantityStatus,
    });

    String? itemCode;
    String? itemName;
    String? itemNameTr;
    int? availableQuantity;
    int? orderedQuantity;
    int? quantityDifference;
    int? quantityStatus;

    factory Quantity.fromJson(Map<String, dynamic> json) => Quantity(
        itemCode: json["item_code"],
        itemName: json["item_name"],
        itemNameTr: json["item_name_tr"],
        availableQuantity: json["available_quantity"],
        orderedQuantity: json["ordered_quantity"],
        quantityDifference: json["quantity_difference"],
        quantityStatus: json["quantity_status"],
    );

    Map<String, dynamic> toJson() => {
        "item_code": itemCode,
        "item_name": itemName,
        "item_name_tr": itemNameTr,
        "available_quantity": availableQuantity,
        "ordered_quantity": orderedQuantity,
        "quantity_difference": quantityDifference,
        "quantity_status": quantityStatus,
    };
}