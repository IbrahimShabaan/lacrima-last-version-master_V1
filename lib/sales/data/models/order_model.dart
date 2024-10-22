class OrderModel {
  String? id;
  int? tracking;
  String? price;
  String? shipment;
  String? issueDate;
  String? description;
  String? customerName;
  String? customerToken;
  String? receivingTime;
  List<dynamic>? product;

  OrderModel({
    this.id,
    this.price,
    this.product,
    this.shipment,
    this.tracking,
    this.issueDate,
    this.description,
    this.customerName,
    this.customerToken,
    this.receivingTime,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    product = json['product'];
    shipment = json['shipment'];
    tracking = json['tracking'];
    issueDate = json['issueDate'];
    description = json['description'];
    customerName = json['customerName'];
    customerToken = json['customerToken'];
    receivingTime = json['receivingTime'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'price': price,
        'product': product,
        'shipment': shipment,
        'tracking': tracking,
        'issueDate': issueDate,
        'description': description,
        'customerName': customerName,
        'receivingTime': receivingTime,
        'customerToken': customerToken,
      };
}

class ProductModel {
  String? prodSize;
  String? quantity;
  String? prodImage;
  String? prodTitle;
  String? prodFlavor;

  ProductModel({
    this.quantity,
    this.prodSize,
    this.prodImage,
    this.prodTitle,
    this.prodFlavor,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    prodSize = json['prodSize'];
    prodImage = json['prodImage'];
    prodTitle = json['prodTitle'];
    prodFlavor = json['prodFlavor'];
  }

  Map<String, dynamic> toJson() => {
        'quantity': quantity,
        'prodSize': prodSize,
        'prodImage': prodImage,
        'prodTitle': prodTitle,
        'prodFlavor': prodFlavor,
      };
}
