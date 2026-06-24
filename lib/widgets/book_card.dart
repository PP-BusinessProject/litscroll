import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../api/api.dart';

class BookCard extends HookConsumerWidget {
  const BookCard(this.book, {super.key});

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) => const Placeholder();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties..add(DiagnosticsProperty<Book>('book', book)),
      );
}
