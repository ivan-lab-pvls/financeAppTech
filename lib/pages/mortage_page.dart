import 'dart:math';

import 'package:financial_calc_app/model/calculate_mortage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MortgePage extends StatefulWidget {
  const MortgePage({super.key});

  @override
  State<MortgePage> createState() => _MortgePageState();
}

class _MortgePageState extends State<MortgePage> {
  TextEditingController realEstateController = TextEditingController();
  TextEditingController initialContributionController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  TextEditingController morategeTermController = TextEditingController();
  double mounthlyPayment = 0.0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.only(top: 60),
                decoration: const BoxDecoration(
                    color: Color(0xFFf9f9f9),
                    border:
                        Border(bottom: BorderSide(color: Color(0xFFD6D6D8)))),
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 44, 16, 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Ипотечный\nкалькулятор',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                height: 48 / 40),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Стоимость имущества',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        controller: realEstateController,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1.5),
                          ),
                        ),
                        onChanged: (text) {
                          realEstateController.text = text;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Первоначальный взнос',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        controller: initialContributionController,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1.5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xFFDDDDDD), width: 1.5),
                          ),
                        ),
                        onChanged: (text) {
                          initialContributionController.text = text;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Срок',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              controller: morategeTermController,
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDDDDDD), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDDDDDD), width: 1.5),
                                ),
                              ),
                              onChanged: (text) {
                                morategeTermController.text = text;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '% Ставка',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              controller: interestRateController,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDDDDDD), width: 1.5),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFDDDDDD), width: 1.5),
                                ),
                              ),
                              onChanged: (text) {
                                interestRateController.text = text;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: InkWell(
                      onTap: () {
                        mounthlyPayment = 0.0;
                        CalculateMortage mortage = CalculateMortage();
                        if (num.tryParse(interestRateController.text) != null &&
                            num.tryParse(realEstateController.text) != null &&
                            num.tryParse(morategeTermController.text) != null &&
                            num.tryParse(initialContributionController.text) !=
                                null) {
                          double interestRate =
                              num.tryParse(interestRateController.text)!
                                      .toDouble() /
                                  100 /
                                  12;
                          mounthlyPayment = ((num.tryParse(
                                          realEstateController.text)!
                                      .toDouble() -
                                  num.tryParse(
                                          initialContributionController.text)!
                                      .toDouble()) *
                              ((interestRate *
                                      pow(
                                          (1 + interestRate),
                                          num.tryParse(morategeTermController
                                                  .text)! *
                                              12)) /
                                  (pow(
                                          (1 + interestRate),
                                          num.tryParse(morategeTermController
                                                  .text)! *
                                              12) -
                                      1)));
                          mortage.mountlyPayment = mounthlyPayment;
                          //Last mortage
                          mortage.creditAmount = num.tryParse(
                                      realEstateController.text)!
                                  .toDouble() -
                              num.tryParse(initialContributionController.text)!
                                  .toDouble();
                          mortage.accruedInterest = ((mortage.mountlyPayment! *
                                  num.tryParse(morategeTermController.text)! *
                                  12) -
                              (num.tryParse(realEstateController.text)!
                                      .toDouble() -
                                  num.tryParse(
                                          initialContributionController.text)!
                                      .toDouble()));
                          mortage.mortageTerm =
                              num.tryParse(morategeTermController.text)!
                                  .toInt();
                          mortage.debtInterest = ((mortage.mountlyPayment! *
                              num.tryParse(morategeTermController.text)! *
                              12));
                          // addToSP(expenses, incomes, user, mortage);

                          //mortagePage = EMortagePage.mortageResult;
                          showModalBottomSheet(
                              isScrollControlled: true,
                              shape: ContinuousRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              backgroundColor: Colors.white,
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height - 300),
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 14, bottom: 40),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16, bottom: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Ипотечный калькулятор\nрассчитал',
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
                                          padding: EdgeInsets.only(bottom: 16),
                                          child: Divider(
                                            color: Color(0xFFD6D6D8),
                                            height: 1,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16, bottom: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Процентная ставка',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF828282),
                                                        fontSize: 16,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: LinearPercentIndicator(
                                                width: 358,
                                                lineHeight: 30,
                                                center: Text(
                                                  '${(mortage.accruedInterest! / (mortage.creditAmount! + mortage.accruedInterest!) * 100).toStringAsFixed(0)}%',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                barRadius:
                                                    const Radius.circular(8),
                                                percent: mortage
                                                        .accruedInterest! /
                                                    (mortage.creditAmount! +
                                                        mortage
                                                            .accruedInterest!),
                                                progressColor:
                                                    const Color(0xFFEB5757),
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  left: 16, bottom: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Основной долг',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF828282),
                                                        fontSize: 16,
                                                        fontFamily: 'Roboto'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: LinearPercentIndicator(
                                                center: Text(
                                                  '${(mortage.creditAmount! / (mortage.creditAmount! + mortage.accruedInterest!) * 100).toStringAsFixed(0)}%',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                                width: 358,
                                                lineHeight: 30,
                                                barRadius:
                                                    const Radius.circular(8),
                                                percent: mortage.creditAmount! /
                                                    (mortage.creditAmount! +
                                                        mortage
                                                            .accruedInterest!),
                                                progressColor:
                                                    const Color(0xFFEB5757),
                                                backgroundColor:
                                                    const Color(0xFFD9D9D9),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, left: 16, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Основной долг',
                                                style: TextStyle(
                                                    color: Color(0xFF828282),
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                '${mortage.creditAmount!.toStringAsFixed(0)} ₽',
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 8, left: 16, right: 16),
                                          child: Divider(
                                            color: Color(0xFFD6D6D8),
                                            height: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, left: 16, bottom: 40),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Процентная ставка',
                                                style: TextStyle(
                                                    color: Color(0xFF828282),
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                '${mortage.accruedInterest!.toStringAsFixed(0)} ₽',
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, left: 16, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Ежемесячная оплата',
                                                style: TextStyle(
                                                    color: Color(0xFF828282),
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                '${mortage.mountlyPayment!.toStringAsFixed(0)} ₽',
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 8, left: 16, right: 16),
                                          child: Divider(
                                            color: Color(0xFFD6D6D8),
                                            height: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, left: 16, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Начисленные проценты',
                                                style: TextStyle(
                                                    color: Color(0xFF828282),
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                '${mortage.accruedInterest!.toStringAsFixed(0)} ₽',
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 8, left: 16, right: 16),
                                          child: Divider(
                                            color: Color(0xFFD6D6D8),
                                            height: 1,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 16, left: 16, bottom: 8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Долг + проценты',
                                                style: TextStyle(
                                                    color: Color(0xFF828282),
                                                    fontSize: 16,
                                                    fontFamily: 'Roboto'),
                                              ),
                                              Text(
                                                '${(mortage.accruedInterest! + mortage.creditAmount!).toStringAsFixed(0)} ₽',
                                                style: const TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: const Color(0xFFEB5757),
                            borderRadius: BorderRadius.circular(16)),
                        child: const Text(
                          'Рассчитать',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
