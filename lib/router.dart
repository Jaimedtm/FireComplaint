import 'package:flutter/material.dart';
import 'package:sample_firebase/pages/complaint-page.dart';
import 'pages/home-page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'complaint': (BuildContext context) => ComplaintPage(),
    //'dev-action': (BuildContext context) => ActionPage(),
  };
}
