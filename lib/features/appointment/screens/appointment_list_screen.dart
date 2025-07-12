import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/appointment_provider.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch appointments when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentProvider>(
        context,
        listen: false,
      ).fetchAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: Consumer<AppointmentProvider>(
        builder: (context, appointmentProvider, child) {
          if (appointmentProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (appointmentProvider.appointments.isEmpty) {
            return const Center(child: Text('No appointments found.'));
          } else {
            return ListView.builder(
              itemCount: appointmentProvider.appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointmentProvider.appointments[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(appointment.title),
                    subtitle: Text(
                      '${appointment.description}\n' '\${app_date_utils.DateUtils.formatDateTime(appointment.startTime)} - \${app_date_utils.DateUtils.formatTime(appointment.endTime)}',
                    ),
                    trailing: Text(
                      appointment.status.toString().split('.').last,
                    ),
                    onTap: () {
                      // TODO: Navigate to appointment detail screen
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to book appointment screen
          print('Add new appointment');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
