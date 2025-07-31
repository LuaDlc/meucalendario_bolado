import 'package:flutter/material.dart';

import 'presentation/pages/calendar_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Calendário Bolado',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalendarPage(),
    );
  }
}
