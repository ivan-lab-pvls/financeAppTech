class UserItem {
  String? totalExpenses;
  String? totalIncomes;

  UserItem({this.totalExpenses, this.totalIncomes});

  factory UserItem.fromJson(Map<String, dynamic> parsedJson) {
    return UserItem(
      totalExpenses: parsedJson['totalExpenses'] ?? "",
      totalIncomes: parsedJson['totalIncomes'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"totalExpenses": totalExpenses, "totalIncomes": totalIncomes};
  }
}
