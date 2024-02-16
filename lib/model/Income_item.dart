enum ECategoryIncomeType {
  cash("Заработная плата"),
  investemnts("Инвестиции"),
  rent("Рента"),
  other("Другое");

  const ECategoryIncomeType(this.text);
  final String text;
}

class IncomeItem {
  String? description;
  DateTime? date;
  double? cost;
  ECategoryIncomeType? type;

  IncomeItem({this.description, this.date, this.cost, this.type});

  factory IncomeItem.fromJson(Map<String, dynamic> parsedJson) {
    return IncomeItem(
        description: parsedJson['description'] ?? "",
        cost: parsedJson['cost'] ?? "",
        type: ECategoryIncomeType.values.byName(parsedJson['type']),
        date: DateTime.tryParse(parsedJson['date']));
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "cost": cost,
      "type": type!.name,
      "date": date.toString(),
    };
  }
}
