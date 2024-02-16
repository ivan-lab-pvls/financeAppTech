import 'package:financial_calc_app/model/Income_item.dart';
import 'package:financial_calc_app/model/expense_item.dart';
import 'package:financial_calc_app/widgets/line_chart_widget.dart';
import 'package:flutter/material.dart';

enum EFilterDate { today, week, month, year }

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage(
      {super.key, required this.incomes, required this.expenses});
  final List<IncomeItem> incomes;
  final List<ExpenseItem> expenses;

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int number = 0;
  EFilterDate currentFilter = EFilterDate.today;
  int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  final now = DateTime.now();
  dynamic firstJan;
  dynamic weekNumber;
  @override
  void initState() {
    super.initState();
    firstJan = DateTime(now.year, 1, 1);
    weekNumber = weeksBetween(firstJan, now);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                ),
                child: Container(
                  padding: const EdgeInsets.only(top: 60),
                  decoration: const BoxDecoration(
                    color: Color(0xFFf9f9f9),
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 44, 16, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Аналитика',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 43,
                        child: TabBar(
                          onTap: (index) {
                            number = index;
                            if (index == 0) {
                              currentFilter = EFilterDate.today;
                            } else if (index == 1) {
                              currentFilter = EFilterDate.week;
                            } else if (index == 2) {
                              currentFilter = EFilterDate.month;
                            } else if (index == 3) {
                              currentFilter = EFilterDate.year;
                            }
                            setState(() {});
                          },
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          unselectedLabelColor: const Color(0xff999999),
                          indicatorColor: const Color(0xffEB5757),
                          labelColor: const Color(0xffEB5757),
                          labelStyle: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xffEB5757),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          unselectedLabelStyle: const TextStyle(
                              fontFamily: 'Roboto',
                              color: Color(0xff999999),
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          tabs: const [
                            Tab(
                              child: Row(children: [
                                Text(
                                  'Сегодня',
                                )
                              ]),
                            ),
                            Tab(
                              child: Row(children: [
                                Text(
                                  'Неделя',
                                )
                              ]),
                            ),
                            Tab(
                              child: Row(children: [
                                Text(
                                  'Месяц',
                                )
                              ]),
                            ),
                            Tab(
                              child: Row(children: [
                                Text(
                                  'Год',
                                )
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    Column(children: [
                      BarChartWidget(
                        pointsIncomes: widget.incomes
                            .where((element) =>
                                element.date!.day == DateTime.now().day &&
                                element.date!.year == DateTime.now().year &&
                                element.date!.month == DateTime.now().month)
                            .toList(),
                        pointsExpenses: widget.expenses
                            .where((element) =>
                                element.date!.day == DateTime.now().day &&
                                element.date!.year == DateTime.now().year &&
                                element.date!.month == DateTime.now().month)
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Общая сумма',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes() - getAllExpenses()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Доходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 8, left: 16, right: 16),
                        child: Divider(
                          color: Color(0xFFD6D6D8),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Расходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              getAllExpenses() != 0
                                  ? '-${getAllExpenses()} ₽'
                                  : '0 ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Column(children: [
                      BarChartWidget(
                        pointsIncomes: widget.incomes
                            .where((element) =>
                                weeksBetween(firstJan, now) ==
                                weeksBetween(firstJan, element.date!))
                            .toList(),
                        pointsExpenses: widget.expenses
                            .where((element) =>
                                weeksBetween(firstJan, now) ==
                                weeksBetween(firstJan, element.date!))
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Общая сумма',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes() - getAllExpenses()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Доходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 8, left: 16, right: 16),
                        child: Divider(
                          color: Color(0xFFD6D6D8),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Расходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              getAllExpenses() != 0
                                  ? '-${getAllExpenses()} ₽'
                                  : '0 ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Column(children: [
                      BarChartWidget(
                        pointsIncomes: widget.incomes
                            .where((element) =>
                                element.date!.month == DateTime.now().month &&
                                element.date!.year == DateTime.now().year)
                            .toList(),
                        pointsExpenses: widget.expenses
                            .where((element) =>
                                element.date!.month == DateTime.now().month &&
                                element.date!.year == DateTime.now().year)
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Общая сумма',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes() - getAllExpenses()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Доходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 8, left: 16, right: 16),
                        child: Divider(
                          color: Color(0xFFD6D6D8),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Расходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              getAllExpenses() != 0
                                  ? '-${getAllExpenses()} ₽'
                                  : '0 ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ]),
                    Column(children: [
                      BarChartWidget(
                        pointsIncomes: widget.incomes
                            .where((element) =>
                                element.date!.year == DateTime.now().year)
                            .toList(),
                        pointsExpenses: widget.expenses
                            .where((element) =>
                                element.date!.year == DateTime.now().year)
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 24, bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Общая сумма',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes() - getAllExpenses()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Доходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              '${getAllIncomes()} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.only(bottom: 8, left: 16, right: 16),
                        child: Divider(
                          color: Color(0xFFD6D6D8),
                          height: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 16, left: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Расходы',
                              style: TextStyle(
                                  color: Color(0xFF828282),
                                  fontSize: 16,
                                  fontFamily: 'Roboto'),
                            ),
                            Text(
                              getAllExpenses() != 0
                                  ? '-${getAllExpenses()} ₽'
                                  : '0 ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getAllIncomes() {
    int cost = 0;
    if (currentFilter == EFilterDate.today) {
      for (var income in widget.incomes
          .where((element) =>
              element.date!.day == DateTime.now().day &&
              element.date!.month == DateTime.now().month &&
              element.date!.year == DateTime.now().year)
          .toList()) {
        cost = cost + income.cost!.toInt();
      }
    } else if (currentFilter == EFilterDate.week) {
      for (var income in widget.incomes
          .where((element) =>
              weeksBetween(firstJan, now) ==
              weeksBetween(firstJan, element.date!))
          .toList()) {
        cost = cost + income.cost!.toInt();
      }
    } else if (currentFilter == EFilterDate.month) {
      for (var income in widget.incomes
          .where((element) =>
              element.date!.month == DateTime.now().month &&
              element.date!.year == DateTime.now().year)
          .toList()) {
        cost = cost + income.cost!.toInt();
      }
    } else if (currentFilter == EFilterDate.year) {
      for (var income in widget.incomes
          .where((element) => element.date!.year == DateTime.now().year)
          .toList()) {
        cost = cost + income.cost!.toInt();
      }
    } else {
      return 0;
    }
    return cost;
  }

  int getAllExpenses() {
    int cost = 0;
    if (currentFilter == EFilterDate.today) {
      for (var expense in widget.expenses
          .where((element) =>
              element.date!.day == DateTime.now().day &&
              element.date!.month == DateTime.now().month &&
              element.date!.year == DateTime.now().year)
          .toList()) {
        cost = cost + expense.cost!.toInt();
      }
    } else if (currentFilter == EFilterDate.week) {
      for (var expense in widget.expenses
          .where((element) =>
              weeksBetween(firstJan, now) ==
              weeksBetween(firstJan, element.date!))
          .toList()) {
        cost = cost + expense.cost!.toInt();
      }
    } else if (currentFilter == EFilterDate.month) {
      for (var expense in widget.expenses
          .where((element) =>
              element.date!.month == DateTime.now().month &&
              element.date!.year == DateTime.now().year)
          .toList()) {
        cost = cost + expense.cost!.toInt();
      }
    } else if (currentFilter == EFilterDate.year) {
      for (var expense in widget.expenses
          .where((element) => element.date!.year == DateTime.now().year)
          .toList()) {
        cost = cost + expense.cost!.toInt();
      }
    } else {
      return 0;
    }
    return cost;
  }
}
