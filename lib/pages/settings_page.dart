import 'package:financial_calc_app/pages/trms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key, required this.callBack});
  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
              padding: const EdgeInsets.only(top: 60),
              decoration: const BoxDecoration(
                  color: Color(0xFFf9f9f9),
                  border: Border(bottom: BorderSide(color: Color(0xFFD6D6D8)))),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 44, 16, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Настройки',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: InkWell(
              onTap: () {
                callBack();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 13, bottom: 13),
                decoration: BoxDecoration(
                    color: const Color(0xFFf9f9f9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFD6D6D8),
                    )),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Image.asset('assets/restart.png'),
                  const Text(
                    'Сбросить сумму',
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  )
                ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
            child: InkWell(
              onTap: () {
               Share.share('Check out my Pocket Helper. Download - ');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/share.png'),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Поделиться с друзьями',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                      )
                    ],
                  ),
                  Image.asset('assets/Arrow.png'),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Color(0xFFD6D6D8),
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const TRMS(
                            link: 'https://docs.google.com/document/d/1Z6-hvdGDrDHYwAtPpiX88PhW_PP0sAL3MgBo8OWlZnc/edit?usp=sharing',
                          )),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/privacy.png'),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Политика конфиденциальности',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                      )
                    ],
                  ),
                  Image.asset('assets/Arrow.png'),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Color(0xFFD6D6D8),
              height: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 13, 16, 13),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const TRMS(
                            link: 'https://docs.google.com/document/d/11l3mHIaYPDlKGZZOihZp50_QMZf-aOk3oFpEfA0i81g/edit?usp=sharing',
                          )),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/terms.png'),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'Условия эксплуатации',
                        style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                      )
                    ],
                  ),
                  Image.asset('assets/Arrow.png'),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}



