enum ECategoryExpenseType {
  food("Еда"),
  entertainment("Закупки"),
  financialOperations("Транспорт"),
  other("Другое");

  const ECategoryExpenseType(this.text);
  final String text;
}

class ExpenseItem {
  String? description;
  DateTime? date;
  double? cost;
  ECategoryExpenseType? type;

  ExpenseItem({this.description, this.date, this.cost, this.type});

  factory ExpenseItem.fromJson(Map<String, dynamic> parsedJson) {
    return ExpenseItem(
        description: parsedJson['description'] ?? "",
        cost: parsedJson['cost'] ?? "",
        type: ECategoryExpenseType.values.byName(parsedJson['type']),
        date: DateTime.tryParse(parsedJson['date']));
  }

  Map<String, dynamic> toJson() {
    return {
      "description": description,
      "cost": cost,
      "date": date.toString(),
      "type": type!.name,
    };
  }
}
