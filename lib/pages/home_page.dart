import 'dart:convert';

import 'package:financial_calc_app/model/Income_item.dart';
import 'package:financial_calc_app/model/expense_item.dart';
import 'package:financial_calc_app/model/user.dart';
import 'package:financial_calc_app/pages/analytics_page.dart';
import 'package:financial_calc_app/pages/mortage_page.dart';
import 'package:financial_calc_app/pages/news_page.dart';
import 'package:financial_calc_app/pages/settings_page.dart';
import 'package:financial_calc_app/widgets/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

UserItem user = UserItem();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IncomeItem> incomes = [];
  List<ExpenseItem> expenses = [];
  TextEditingController textControllerIncome = TextEditingController();
  TextEditingController textControllerIncomeDate = TextEditingController();
  TextEditingController textControllerIncomeDescription =
      TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int number = 0;
  List<ECategoryIncomeType> categoryTypeIncomeList = [
    ECategoryIncomeType.cash,
    ECategoryIncomeType.investemnts,
    ECategoryIncomeType.rent,
    ECategoryIncomeType.other
  ];
  List<ECategoryExpenseType> categoryTypeExpenseList = [
    ECategoryExpenseType.food,
    ECategoryExpenseType.entertainment,
    ECategoryExpenseType.financialOperations,
    ECategoryExpenseType.other
  ];
  ECategoryIncomeType currentIncomeType = ECategoryIncomeType.cash;
  ECategoryExpenseType currentExpenseType = ECategoryExpenseType.food;
  @override
  void initState() {
    super.initState();
    getSP();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          getContent(),
          BottomBar(
            callBack: () {
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  Widget getContent() {
    if (page == EPageOnSelect.homePage) {
      return DefaultTabController(
        length: 2,
        initialIndex: number,
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFf9f9f9),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 60, 16, 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  backgroundColor: Colors.white,
                                  constraints: BoxConstraints(
                                      maxHeight:
                                          MediaQuery.of(context).size.height -
                                              300),
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                        builder: (context, setstate) {
                                      return SingleChildScrollView(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14, bottom: 40),
                                          child: Column(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16,
                                                  right: 16,
                                                  bottom: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                    'Добавить доходы',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Image.asset(
                                                          'assets/close.png'))
                                                ],
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 16),
                                              child: Divider(
                                                color: Color(0xFFD6D6D8),
                                                height: 1,
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  16, 0, 16, 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Описание',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 0, 16, 16),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                                controller:
                                                    textControllerIncomeDescription,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              width: 1)),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  16, 0, 16, 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Сумма',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: TextField(
                                                cursorColor: Colors.black,
                                                inputFormatters: <TextInputFormatter>[
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                keyboardType:
                                                    TextInputType.number,
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                                controller:
                                                    textControllerIncome,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              width: 1)),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  16, 16, 16, 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Дата',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              child: TextField(
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return Dialog(
                                                          child: SizedBox(
                                                            width: 500,
                                                            height: 100,
                                                            child:
                                                                CupertinoTheme(
                                                              data:
                                                                  const CupertinoThemeData(
                                                                textTheme: CupertinoTextThemeData(
                                                                    dateTimePickerTextStyle: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            'Roboto',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            15)),
                                                              ),
                                                              child:
                                                                  CupertinoDatePicker(
                                                                mode:
                                                                    CupertinoDatePickerMode
                                                                        .date,
                                                                itemExtent: 50,
                                                                initialDateTime:
                                                                    _selectedDate,
                                                                onDateTimeChanged:
                                                                    (DateTime
                                                                        newDate) {
                                                                  setstate(() {
                                                                    _selectedDate =
                                                                        newDate;
                                                                    textControllerIncomeDate
                                                                        .text = DateFormat(
                                                                            ' dd MMMM, yyyy',
                                                                            'ru_RU')
                                                                        .format(
                                                                            _selectedDate);
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                cursorColor: Colors.black,
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                                readOnly: true,
                                                controller:
                                                    textControllerIncomeDate,
                                                decoration: InputDecoration(
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                    borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        width: 1.0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                                  Radius
                                                                      .circular(
                                                                          15)),
                                                          borderSide: BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.2),
                                                              width: 1)),
                                                ),
                                              ),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  16, 16, 16, 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Категории',
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (number == 0)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: getCategoriesIncome(() {
                                                  setstate(() {});
                                                }),
                                              ),
                                            if (number == 1)
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: getCategoriesExpense(() {
                                                  setstate(() {});
                                                }),
                                              ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      16, 20, 16, 0),
                                              child: InkWell(
                                                onTap: () {
                                                  if (number == 0) {
                                                    IncomeItem income =
                                                        IncomeItem();
                                                    income.cost = num.tryParse(
                                                            textControllerIncome
                                                                .text)!
                                                        .toDouble();
                                                    income.date =
                                                        DateTime.now();
                                                    income.description =
                                                        textControllerIncomeDescription
                                                            .text;
                                                    income.type =
                                                        currentIncomeType;
                                                    incomes.add(income);
                                                  } else {
                                                    ExpenseItem expense =
                                                        ExpenseItem();
                                                    expense.cost = num.tryParse(
                                                            textControllerIncome
                                                                .text)!
                                                        .toDouble();
                                                    expense.date =
                                                        DateTime.now();
                                                    expense.description =
                                                        textControllerIncomeDescription
                                                            .text;
                                                    expense.type =
                                                        currentExpenseType;
                                                    expenses.add(expense);
                                                  }
                                                  addToSP(
                                                      expenses, incomes, user);
                                                  int allIncomes = 0;
                                                  int allExpenses = 0;
                                                  for (var income in incomes) {
                                                    allIncomes = allIncomes +
                                                        income.cost!.toInt();
                                                  }
                                                  user.totalIncomes =
                                                      allIncomes.toString();
                                                  for (var expense
                                                      in expenses) {
                                                    allExpenses = allExpenses +
                                                        expense.cost!.toInt();
                                                  }
                                                  user.totalExpenses =
                                                      allExpenses.toString();
                                                  Navigator.pop(context);
                                                  setState(() {});
                                                },
                                                child: Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFEB5757),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: const Text(
                                                    'Добавить',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ),
                                      );
                                    });
                                  });
                            },
                            child: const Text(
                              'Добавить',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Color(0xFFEB5757),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (number == 0)
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Общие доходы',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Color(0xFF999999)),
                            ),
                          ],
                        ),
                      ),
                    if (number == 0)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              user.totalIncomes == null
                                  ? '0 ₽'
                                  : '${user.totalIncomes} ₽',
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    if (number == 1)
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Общие расходы',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: Color(0xFF999999)),
                            ),
                          ],
                        ),
                      ),
                    if (number == 1)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              user.totalExpenses == null
                                  ? '0 ₽'
                                  : '${user.totalExpenses} ₽',
                              style: const TextStyle(
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
                          setState(() {});
                        },
                        isScrollable: true,
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        tabAlignment: TabAlignment.start,
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
                        tabs: [
                          Tab(
                            child: Row(children: [
                              number == 0
                                  ? Image.asset(
                                      'assets/arrow-up.png',
                                      color: const Color(0xffEB5757),
                                    )
                                  : Image.asset(
                                      'assets/arrow-up.png',
                                      color: const Color(0xff999999),
                                    ),
                              const Text(
                                'Доходы',
                              )
                            ]),
                          ),
                          Tab(
                            child: Row(children: [
                              number == 1
                                  ? Image.asset(
                                      'assets/arrow-down.png',
                                      color: const Color(0xffEB5757),
                                    )
                                  : Image.asset(
                                      'assets/arrow-down.png',
                                      color: const Color(0xff999999),
                                    ),
                              const Text(
                                'Расходы',
                              )
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: TabBarView(
                  children: [
                    Column(children: [
                      if (incomes.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Text(
                            'Информации о доходах пока нет, нажмите кнопку "Добавить", что бы добавить доход.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 16),
                          ),
                        ),
                      if (incomes.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: getIncomes(),
                        )
                    ]),
                    Column(children: [
                      if (expenses.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Text(
                            'Информации о расходах пока нет, нажмите кнопку "Добавить", что бы добавить доход.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.black.withOpacity(0.4),
                                fontSize: 16),
                          ),
                        ),
                      if (expenses.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: getExpenses(),
                        )
                    ]),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    } else if (page == EPageOnSelect.analyticsPage) {
      return AnalyticsPage(
        expenses: expenses,
        incomes: incomes,
      );
    } else if (page == EPageOnSelect.profilePage) {
      return SettingsPage(
        callBack: () {
          incomes.clear();
          expenses.clear();
          user.totalExpenses = '0';
          user.totalIncomes = '0';
          addToSP(expenses, incomes, user);
          setState(() {});
        },
      );
    } else if (page == EPageOnSelect.mortagePage) {
      return const MortgePage();
    } else if (page == EPageOnSelect.newsPage) {
      return const NewsPage();
    } else {
      return const Expanded(child: SizedBox());
    }
  }

  Widget getIncomes() {
    List<Widget> list = [];
    for (var income in incomes) {
      list.add(Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '${income.description}',
                                style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                income.type!.text,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          '${income.cost!.toStringAsFixed(0)} ₽',
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        DateFormat(' dd MMMM, yyyy', 'ru_RU')
                            .format(income.date!),
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  )
                ]),
          ),
          const Divider(
            color: Color(0xFFD6D6D8),
            height: 1,
          )
        ],
      ));
    }
    return Column(
      children: list,
    );
  }

  Widget getExpenses() {
    List<Widget> list = [];
    for (var expense in expenses) {
      list.add(Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                '${expense.description}',
                                style: const TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                expense.type!.text,
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(0.5)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          '${expense.cost!.toStringAsFixed(0)} ₽',
                          style: const TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Text(
                        DateFormat(' dd MMMM, yyyy', 'ru_RU')
                            .format(expense.date!),
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black.withOpacity(0.5)),
                      )
                    ],
                  )
                ]),
          ),
          const Divider(
            color: Color(0xFFD6D6D8),
            height: 1,
          )
        ],
      ));
    }
    return Column(
      children: list,
    );
  }

  Widget getCategoriesIncome(Function() callBack) {
    List<Widget> list = [];
    for (var category in categoryTypeIncomeList) {
      list.add(
        InkWell(
          onTap: () {
            currentIncomeType = category;
            callBack();
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: currentIncomeType == category
                    ? const Color(0xFFfce6e6)
                    : const Color(0xFFF9F9F9),
                border: Border.all(
                    color: currentIncomeType == category
                        ? const Color(0xFFEB5757)
                        : const Color(0xFFD6D6D8))),
            child: Row(
              children: [
                if (category == ECategoryIncomeType.cash)
                  Image.asset(
                    'assets/cash.png',
                    color: currentIncomeType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                if (category == ECategoryIncomeType.investemnts)
                  Image.asset(
                    'assets/invest.png',
                    color: currentIncomeType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                if (category == ECategoryIncomeType.rent)
                  Image.asset(
                    'assets/rent.png',
                    color: currentIncomeType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                if (category == ECategoryIncomeType.other)
                  Image.asset(
                    'assets/other.png',
                    color: currentIncomeType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  category.text,
                  style: TextStyle(
                      color: currentIncomeType == category
                          ? const Color(0xFFEB5757)
                          : const Color(0xFF999999),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Widget getCategoriesExpense(Function() callBack) {
    List<Widget> list = [];
    for (var category in categoryTypeExpenseList) {
      list.add(
        InkWell(
          onTap: () {
            currentExpenseType = category;
            callBack();
          },
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: currentExpenseType == category
                    ? const Color(0xFFfce6e6)
                    : const Color(0xFFF9F9F9),
                border: Border.all(
                    color: currentExpenseType == category
                        ? const Color(0xFFEB5757)
                        : const Color(0xFFD6D6D8))),
            child: Row(
              children: [
                if (category == ECategoryExpenseType.food)
                  Image.asset(
                    'assets/food.png',
                    color: currentExpenseType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                if (category == ECategoryExpenseType.entertainment)
                  Image.asset(
                    'assets/cart.png',
                    color: currentExpenseType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                if (category == ECategoryExpenseType.financialOperations)
                  Image.asset(
                    'assets/train.png',
                    color: currentExpenseType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                if (category == ECategoryExpenseType.other)
                  Image.asset(
                    'assets/drink.png',
                    color: currentExpenseType == category
                        ? const Color(0xFFEB5757)
                        : null,
                  ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  category.text,
                  style: TextStyle(
                      color: currentExpenseType == category
                          ? const Color(0xFFEB5757)
                          : const Color(0xFF999999),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      );
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list,
      ),
    );
  }

  Future<void> addToSP(List<ExpenseItem>? expensesList,
      List<IncomeItem>? incomeList, UserItem? user) async {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    if (user != null) {
      prefs.setString('user', jsonEncode(user));
    }
    if (expensesList != null) {
      prefs.setString('expensesLists', jsonEncode(expensesList));
    }
    if (incomeList != null) {
      prefs.setString('incomeLists', jsonEncode(incomeList));
    }
  }

  void getSP() async {
    int allIncomes = 0;
    int allExpenses = 0;
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> jsonData2 =
        jsonDecode(prefs.getString('expensesLists') ?? '[]');
    final List<dynamic> jsonData3 =
        jsonDecode(prefs.getString('incomeLists') ?? '[]');
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      user = UserItem.fromJson(userMap);
    }

    expenses = jsonData2.map<ExpenseItem>((jsonList) {
      {
        return ExpenseItem.fromJson(jsonList);
      }
    }).toList();
    incomes = jsonData3.map<IncomeItem>((jsonList) {
      {
        return IncomeItem.fromJson(jsonList);
      }
    }).toList();
    for (var income in incomes) {
      allIncomes = allIncomes + income.cost!.toInt();
    }
    user.totalIncomes = allIncomes.toString();
    for (var expense in expenses) {
      allExpenses = allExpenses + expense.cost!.toInt();
    }
    user.totalExpenses = allExpenses.toString();
    setState(() {});
  }
}
