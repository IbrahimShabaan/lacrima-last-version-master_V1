class ProductModel {
  String? prodId;
  String? prodImage;
  String? prodTitle;
  String? prodSize;
  String? prodFlavor;
  String? prodDescription;
  String? prodNationality;
  Map<String, dynamic>? nutrition;

  ProductModel({
    this.prodId,
    this.prodImage,
    this.prodTitle,
    this.prodSize,
    this.prodFlavor,
    this.prodDescription,
    this.prodNationality,
    this.nutrition,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    prodId = json['prodId'];
    prodImage = json['prodImage'];
    prodTitle = json['prodTitle'];
    prodSize = json['prodSize'];
    nutrition = json['nutrition'];
    prodFlavor = json['prodFlavor'];
    prodDescription = json['prodDescription'];
    prodNationality = json['prodNationality'];
  }

  Map<String, dynamic> toJson() => {
        'prodId': prodId,
        'prodImage': prodImage,
        'prodTitle': prodTitle,
        'prodSize': prodSize,
        'nutrition': nutrition,
        'prodFlavor': prodFlavor,
        'prodDescription': prodDescription,
        'prodNationality': prodNationality,
      };
}
