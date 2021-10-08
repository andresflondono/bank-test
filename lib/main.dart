import 'package:bank_todo/generated/l10n.dart';
import 'package:bank_todo/redux/store.dart';
import 'package:bank_todo/routes/main_routes.dart';
import 'package:bank_todo/styles/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Redux.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: Redux.store,
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          theme: ThemeData(
              fontFamily: 'Montserrat',
              primaryColor: AppColors.mainColor,
              unselectedWidgetColor: Colors.grey),
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          initialRoute: 'login',
          routes: mainRoutes,
        ));
  }
}
