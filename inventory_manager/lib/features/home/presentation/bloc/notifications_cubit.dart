import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<List<String>> {
  NotificationsCubit() : super([]);

  void addNewNotifications(String newNotification) {
    emit([...state, newNotification]);
  }

  void removeExpiredNotifications(String oldNotification) {
    final List<String> deepCopyNotifications = List.from(state);
    deepCopyNotifications.remove(oldNotification);
    emit(deepCopyNotifications);
  }
}
