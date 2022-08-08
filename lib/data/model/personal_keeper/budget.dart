class Budget {
  late String incomingMoney;
  late String spentMoney;
  late String month;

  Budget({
    required this.incomingMoney,
    required this.spentMoney,
    required this.month,
  });

  Budget.fromJson(Map<String, dynamic> json) {
    incomingMoney = json['incoming'];
    spentMoney = json['spent'];
    month = json['month'];
  }
}
