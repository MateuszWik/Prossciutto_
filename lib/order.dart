// summary_page.dart
import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Dziekujemy za zlozenie zamowienia w naszej aplikacji!',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
            fontFamily: 'LeagueSpartan'),
        ),
      ),
    );
  }
}
