import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sample_firebase/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //La localización es necesaria para que todo el UI funcione en esp
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('es', 'MX'), // En este arr van las locs soportadas
      ],
      title: 'Legal Force Denuncias',
      theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.green,
          textTheme: GoogleFonts.montserratTextTheme()),
      initialRoute: '/',
      routes: getRoutes(),
    );
  }
}
