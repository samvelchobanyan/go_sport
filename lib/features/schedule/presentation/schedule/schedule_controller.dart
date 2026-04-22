import 'package:flutter_riverpod/flutter_riverpod.dart';

// UI-only: which date is currently selected on the schedule screen.
class SelectedDateNotifier extends AutoDisposeNotifier<DateTime> {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void updateDate(DateTime date) {
    state = DateTime(date.year, date.month, date.day);
  }
}

final selectedDateProvider =
    NotifierProvider.autoDispose<SelectedDateNotifier, DateTime>(
  SelectedDateNotifier.new,
);
