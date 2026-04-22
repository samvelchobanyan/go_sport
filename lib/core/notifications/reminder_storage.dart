import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final reminderStorageProvider = Provider<ReminderStorage>(
  (_) => throw UnimplementedError(
    'reminderStorageProvider must be overridden in ProviderScope',
  ),
);

class ReminderStorage {
  static const _storageKey = 'program_reminders';

  final Set<String> _ids = <String>{};

  SharedPreferences? _prefs;

  Set<String> get subscribedIds => UnmodifiableSetView(_ids);

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final stored = _prefs!.getStringList(_storageKey);
    if (stored != null) {
      _ids
        ..clear()
        ..addAll(stored);
    }
  }

  Future<void> add(String slotId) async {
    if (_ids.add(slotId)) {
      await _persist();
    }
  }

  Future<void> remove(String slotId) async {
    if (_ids.remove(slotId)) {
      await _persist();
    }
  }

  Future<void> _persist() async {
    await _prefs!.setStringList(_storageKey, _ids.toList(growable: false));
  }
}
