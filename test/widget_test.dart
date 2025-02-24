import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:project_2/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login test - correct and incorrect password",
      (WidgetTester tester) async {
    // Start the app
    await tester.pumpWidget(MyApp());

    // Find widgets by key
    final usernameField = find.byType(TextField).first;
    final passwordField = find.byType(TextField).last;
    final loginButton = find.byType(ElevatedButton);

    // Enter username
    await tester.enterText(usernameField, "testuser");

    // Enter incorrect password
    await tester.enterText(passwordField, "wrongpassword");
    await tester.tap(loginButton);
    await tester.pump(); // Wait for UI update

    // Verify error message appears
    expect(find.text("Incorrect password! Try again."), findsOneWidget);

    // Enter correct password
    await tester.enterText(passwordField, "123456");
    await tester.tap(loginButton);
    await tester.pumpAndSettle(); // Wait for navigation

    // Verify we navigated to Main Page
    expect(find.text("Welcome to the Main Page!"), findsOneWidget);
  });
}
