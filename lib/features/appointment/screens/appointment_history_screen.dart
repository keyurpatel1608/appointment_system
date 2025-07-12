import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/appointment_provider.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/core/utils/date_utils.dart' as AppDateUtils;

class AppointmentHistoryScreen extends StatefulWidget {
  const AppointmentHistoryScreen({super.key});

  @override
  State<AppointmentHistoryScreen> createState() => _AppointmentHistoryScreenState();
}

class _AppointmentHistoryScreenState extends State<AppointmentHistoryScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch appointments when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentProvider>(context, listen: false).fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment History'),
      ),
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          if (appointmentProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (appointmentProvider.appointments.isEmpty) {
            return const Center(child: Text('No appointment history found.'));
          } else {
            // Filter for past appointments or completed/cancelled ones for history
            final historicalAppointments = appointmentProvider.appointments.where((appt) {
              return appt.endTime.isBefore(DateTime.now()) ||
                     appt.status == AppointmentStatus.completed ||
                     appt.status == AppointmentStatus.cancelled;
            }).toList();

            if (historicalAppointments.isEmpty) {
              return const Center(child: Text('No past appointments to display.'));
            }

            return ListView.builder(
              itemCount: historicalAppointments.length,
              itemBuilder: (context, index) {
                final appointment = historicalAppointments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(appointment.title),
                    subtitle: Text(
                      '${appointment.description}\n' +
                      '${AppDateUtils.DateUtils.formatDateTime(appointment.startTime)} - ${AppDateUtils.DateUtils.formatTime(appointment.endTime)}\n' +
                      'Status: ${appointment.status.toString().split('.').last}',
                    ),
                    onTap: () {
                      // TODO: Navigate to appointment detail screen for history view
                      print('Tapped on historical appointment: ${appointment.title}');
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}