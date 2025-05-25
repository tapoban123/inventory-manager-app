import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_manager/features/home/presentation/bloc/notifications_cubit.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: BlocBuilder<NotificationsCubit, List<String>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return Center(
              child: Text(
                "We do not have any notifications for you right now.",
              ),
            );
          }
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final text = state.reversed.toList()[index];
              return Card(
                child: ListTile(
                  leading: Icon(Icons.warning, color: Colors.amber),
                  title: Text(text),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<NotificationsCubit>().removeExpiredNotifications(text);
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
