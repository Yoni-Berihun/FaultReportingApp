import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fault_reporting_app/main.dart';

void main() {
  testWidgets('App builds smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FaultReportingApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
