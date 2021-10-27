// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:challenge/constants/strings.dart';
import 'package:challenge/views/account/otp_verification_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:challenge/main.dart';

void main() {
  testWidgets('Widgets tests', (WidgetTester tester) async {
    // Build our app and trigger a frame.

    await tester.pumpWidget(const App());
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(FlutterLogo), findsOneWidget);
    print('Found flutter logo on welcome screen');
    expect(find.byType(ElevatedButton), findsOneWidget);
    print('Found button on welcome screen');
    expect(find.textContaining(Strings.welcome), findsOneWidget);

    print('Tapping welcome button');
    await tester.tap(find.byType(ElevatedButton));
    print('Waiting for app to navigate to next page');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    expect(find.textContaining('Step 1 of 4'), findsOneWidget);
    print('found `Step 1 of 4` in next page');

    print('Tapping continue button');
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    expect(find.textContaining(Strings.errorMessageForNumberMustNotBeEmpty),
        findsOneWidget);
    print(
        'found validation error message `${Strings.errorMessageForNumberMustNotBeEmpty}` on phone verification screen');

    await tester.enterText(find.byType(TextFormField), "09000000000");
    print('Entered a valid phone number');
    await tester.pumpAndSettle();
    expect(find.textContaining(Strings.errorMessageForNumberMustNotBeEmpty),
        findsNothing);
    print('Expects validation error message to be gone');

    print('Taps continue again');
    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();
    expect(find.byType(OtpChip), findsNWidgets(6));
    print('finds 6 otp fields');
    expect(find.byKey(const ValueKey('otp')), findsOneWidget);
    print('finds 6 otp text field');
  });
}
