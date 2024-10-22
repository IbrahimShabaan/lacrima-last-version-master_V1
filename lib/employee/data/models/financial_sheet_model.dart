class FinancialSheetModel {
  dynamic january;
  dynamic february;
  dynamic march;
  dynamic april;
  dynamic may;
  dynamic june;
  dynamic july;
  dynamic august;
  dynamic september;
  dynamic october;
  dynamic november;
  dynamic december;

  FinancialSheetModel({
    this.january,
    this.february,
    this.march,
    this.april,
    this.may,
    this.june,
    this.july,
    this.august,
    this.september,
    this.october,
    this.november,
    this.december,
  });

  FinancialSheetModel.fromJson(Map<String, dynamic> json) {
    january = json['january'];
    february = json['february'];
    march = json['march'];
    april = json['april'];
    may = json['may'];
    june = json['june'];
    july = json['july'];
    august = json['august'];
    september = json['september'];
    october = json['october'];
    november = json['november'];
    december = json['december'];
  }

  Map<String, dynamic> toJson() => {
        'january': january,
        'february': february,
        'march': march,
        'april': april,
        'may': may,
        'june': june,
        'july': july,
        'august': august,
        'september': september,
        'october': october,
        'november': november,
        'december': december,
      };
}
