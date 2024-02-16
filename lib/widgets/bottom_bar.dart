import 'package:flutter/material.dart';

enum EPageOnSelect {
  homePage,
  analyticsPage,
  newsPage,
  mortagePage,
  profilePage
}

EPageOnSelect page = EPageOnSelect.homePage;

class BottomBar extends StatefulWidget {
  const BottomBar({super.key, required this.callBack});
  final VoidCallback callBack;

  @override
  State<BottomBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              page = EPageOnSelect.homePage;

              widget.callBack();
              setState(() {});
            },
            child: SizedBox(
                height: 65,
                width: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == EPageOnSelect.homePage
                        ? Image.asset(
                            'assets/home-analytics.png',
                            color: const Color(0xffEB5757),
                          )
                        : Image.asset(
                            'assets/home-analytics.png',
                            color:
                                Colors.black.withOpacity(0.4).withOpacity(0.4),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Главная',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == EPageOnSelect.homePage
                                  ? const Color(0xffEB5757)
                                  : Colors.black.withOpacity(0.4),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              page = EPageOnSelect.analyticsPage;

              widget.callBack();
              setState(() {});
            },
            child: SizedBox(
                height: 65,
                width: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == EPageOnSelect.analyticsPage
                        ? Image.asset(
                            'assets/poll.png',
                            color: const Color(0xffEB5757),
                          )
                        : Image.asset(
                            'assets/poll.png',
                            color:
                                Colors.black.withOpacity(0.4).withOpacity(0.4),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Аналитика',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == EPageOnSelect.analyticsPage
                                  ? const Color(0xffEB5757)
                                  : Colors.black.withOpacity(0.4),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              page = EPageOnSelect.mortagePage;

              widget.callBack();
              setState(() {});
            },
            child: SizedBox(
                height: 65,
                width: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == EPageOnSelect.mortagePage
                        ? Image.asset(
                            'assets/abacus.png',
                            color: const Color(0xffEB5757),
                          )
                        : Image.asset(
                            'assets/abacus.png',
                            color: Colors.black.withOpacity(0.4),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Калькулятор',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == EPageOnSelect.mortagePage
                                  ? const Color(0xffEB5757)
                                  : Colors.black.withOpacity(0.4),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              page = EPageOnSelect.newsPage;

              widget.callBack();
              setState(() {});
            },
            child: SizedBox(
                height: 65,
                width: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == EPageOnSelect.newsPage
                        ? Image.asset(
                            'assets/newspaper-variant.png',
                            color: const Color(0xffEB5757),
                          )
                        : Image.asset(
                            'assets/newspaper-variant.png',
                            color: Colors.black.withOpacity(0.4),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Новости',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == EPageOnSelect.newsPage
                                  ? const Color(0xffEB5757)
                                  : Colors.black.withOpacity(0.4),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
          InkWell(
            onTap: () {
              page = EPageOnSelect.profilePage;

              widget.callBack();
              setState(() {});
            },
            child: SizedBox(
                height: 65,
                width: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    page == EPageOnSelect.profilePage
                        ? Image.asset(
                            'assets/cogs.png',
                            color: const Color(0xffEB5757),
                          )
                        : Image.asset(
                            'assets/cogs.png',
                            color: Colors.black.withOpacity(0.4),
                          ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text('Настройки',
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                              color: page == EPageOnSelect.profilePage
                                  ? const Color(0xffEB5757)
                                  : Colors.black.withOpacity(0.4),
                              fontSize: 10)),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
