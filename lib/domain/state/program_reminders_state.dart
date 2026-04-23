import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/notifications/notification_service.dart';
import 'package:go_sport/core/notifications/reminder_storage.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';

const Duration _reminderLeadTime = Duration(minutes: 10);

class ProgramRemindersNotifier extends Notifier<Set<String>> {
  late final ReminderStorage _storage;
  late final NotificationService _notifications;

  @override
  Set<String> build() {
    _storage = ref.watch(reminderStorageProvider);
    _notifications = ref.watch(notificationServiceProvider);
    return Set<String>.from(_storage.subscribedIds);
  }

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
    state = {...state, program.id};
  }

  Future<void> _unsubscribe(ScheduledProgram program) async {
    await _storage.remove(program.id);
    await _notifications.cancel(_notificationId(program.id));
    state = state.difference({program.id});
  }

  int _notificationId(String slotId) => slotId.hashCode;
}

final programRemindersProvider =
    NotifierProvider<ProgramRemindersNotifier, Set<String>>(
      ProgramRemindersNotifier.new,
    );
