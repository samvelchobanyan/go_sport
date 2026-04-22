import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/notifications/notification_service.dart';
import 'package:go_sport/core/notifications/reminder_storage.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';

const Duration _reminderLeadTime = Duration(minutes: 10);

final programRemindersProvider =
    StateNotifierProvider<ProgramRemindersNotifier, Set<String>>((ref) {
  return ProgramRemindersNotifier(
    storage: ref.watch(reminderStorageProvider),
    notifications: ref.watch(notificationServiceProvider),
  );
});

class ProgramRemindersNotifier extends StateNotifier<Set<String>> {
  ProgramRemindersNotifier({
    required ReminderStorage storage,
    required NotificationService notifications,
  })  : _storage = storage,
        _notifications = notifications,
        super(Set<String>.from(storage.subscribedIds));

  final ReminderStorage _storage;
  final NotificationService _notifications;

  Future<void> toggle(ScheduledProgram program) async {
    if (state.contains(program.id)) {
      await _unsubscribe(program);
    } else {
      await _subscribe(program);
    }
  }

  Future<void> _subscribe(ScheduledProgram program) async {
    await _storage.add(program.id);
    final reminderAt = program.startDate.subtract(_reminderLeadTime);
    if (reminderAt.isAfter(DateTime.now())) {
      await _notifications.scheduleAt(
        id: _notificationId(program.id),
        title: program.title,
        body: 'Starts in 10 minutes',
        at: reminderAt,
        payload: kRadioSchedulePayload,
      );
    }
    state = Set<String>.from(_storage.subscribedIds);
  }

  Future<void> _unsubscribe(ScheduledProgram program) async {
    await _storage.remove(program.id);
    await _notifications.cancel(_notificationId(program.id));
    state = Set<String>.from(_storage.subscribedIds);
  }

  int _notificationId(String slotId) => slotId.hashCode;
}
