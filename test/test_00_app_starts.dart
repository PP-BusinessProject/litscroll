import 'package:flutter_test/flutter_test.dart';
import 'package:litscroll/routes.dart';
import 'package:litscroll/routes/route_04_book.dart';
import 'package:litscroll/widgets/book_card.dart';

import 'utils/routes.dart';

Future<void> main() async {
  testWidgets('app starts', Routes.onboardingWelcome.pump);

  testWidgets('home shows books and opens book details', (
    WidgetTester tester,
  ) async {
    await Routes.home.pump(tester);
    await tester.tap(find.byType(BookCard).first);
    await tester.pumpAndSettle();
    expect(find.byType(BookScreen), findsOneWidget);
  });

  testWidgets('home shows books and opens book details', (
    WidgetTester tester,
  ) async {
    await Routes.home.pump(tester);
    await tester.tap(find.byType(BookCard).first);
    await tester.pumpAndSettle();
    expect(find.byType(BookScreen), findsOneWidget);
  });
}
