import 'package:collection/collection.dart';
import 'package:financial_calc_app/model/Income_item.dart';
import 'package:financial_calc_app/model/expense_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({Key? key, this.pointsExpenses, this.pointsIncomes})
      : super(key: key);

  final List<ExpenseItem>? pointsExpenses;
  final List<IncomeItem>? pointsIncomes;

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  double totalCost = 0.0;
  Map<int, List<ExpenseItem>> transactionsMapExpenses = {};
  Map<int, List<IncomeItem>> transactionsMapIncomes = {};
  bool add = false;
  int savedDateTime = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pointsExpenses != null && widget.pointsExpenses!.isNotEmpty) {
      transactionsMapExpenses =
          groupBy(widget.pointsExpenses!, (ExpenseItem e) => e.date!.month);
    }
    if (widget.pointsIncomes != null && widget.pointsIncomes!.isNotEmpty) {
      transactionsMapIncomes =
          groupBy(widget.pointsIncomes!, (IncomeItem e) => e.date!.month);
    }
    totalCost = 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xFFF9F9F9),
            border: Border.all(
              color: const Color(0xFFD6D6D8),
            ),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.only(left: 8, bottom: 8, top: 40, right: 8),
        child: AspectRatio(
          aspectRatio: 2,
          child: BarChart(
            BarChartData(
              barTouchData: BarTouchData(enabled: false),
              backgroundColor: const Color(0xFFF9F9F9),
              alignment: BarChartAlignment.start,
              barGroups: _chartGroups(),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) {
                  return const FlLine(
                    color: Color(0xFFF9F9F9),
                    strokeWidth: 1,
                  );
                },
              ),
              borderData: FlBorderData(
                  border: Border.all(color: const Color(0xFFF9F9F9))),
              titlesData: const FlTitlesData(show: false),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    List<BarChartGroupData> list = [];
    savedDateTime = 0;
    if (transactionsMapExpenses.isNotEmpty) {
      transactionsMapExpenses.forEach((key, value) {
        if (savedDateTime != key) {
          for (var transaction
              in value.where((element) => element.date!.month == key)) {
            totalCost = totalCost + transaction.cost!;
          }
          savedDateTime = key;
          list.add(BarChartGroupData(x: savedDateTime, barRods: [
            BarChartRodData(
                toY: totalCost,
                color: const Color(0xFFEB5757),
                width: 5,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ))
          ]));

          totalCost = 0.0;
        }
      });
    }
    if (transactionsMapIncomes.isNotEmpty) {
      transactionsMapIncomes.forEach((key, value) {
        for (var transaction
            in value.where((element) => element.date!.month == key)) {
          totalCost = totalCost + transaction.cost!;
        }
        savedDateTime = key;
        list.add(BarChartGroupData(x: savedDateTime, barRods: [
          BarChartRodData(
              toY: totalCost,
              color: const Color(0xFFEB5757),
              width: 5,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ))
        ]));

        totalCost = 0.0;
      });
    }
    return list;
  }
}
