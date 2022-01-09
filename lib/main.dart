import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/main_bloc.dart';
import 'navigation/navigation_page.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<MainBloc>(
        create: (BuildContext context) => MainBloc(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Airbnb'),
      debugShowCheckedModeBanner: false,
      title: 'ValidusCoin',
      supportedLocales: [
        Locale('en', 'US'),
      ],
      home: NavigationPage(),
    );
  }
}