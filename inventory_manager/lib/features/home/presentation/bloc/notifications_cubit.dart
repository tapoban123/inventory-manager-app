import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsCubit extends Cubit<List<String>> {
  NotificationsCubit() : super([]);

  void addNewNotifications(String newNotification) {
    emit([...state, newNotification]);
  }
}
