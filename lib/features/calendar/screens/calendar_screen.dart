import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/appointment_provider.dart';
import 'package:appointment_system/core/models/appointment_model.dart';
import 'package:appointment_system/config/routes/app_router.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Appointment> _selectedAppointments = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _fetchAppointmentsForSelectedDay(_selectedDay!);
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _fetchAppointmentsForSelectedDay(selectedDay);
    }
  }

  List<Appointment> _getAppointmentsForDay(DateTime day) {
    // This method will filter appointments based on the selected day
    // In a real app, you'd fetch appointments from your provider
    // For now, it returns a dummy list
    final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
    return appointmentProvider.appointments.where((appointment) {
      return isSameDay(appointment.startTime, day);
    }).toList();
  }

  void _fetchAppointmentsForSelectedDay(DateTime day) async {
    final appointmentProvider = Provider.of<AppointmentProvider>(context, listen: false);
    await appointmentProvider.fetchAppointments(); // Ensure all appointments are fetched
    setState(() {
      _selectedAppointments = _getAppointmentsForDay(day);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar<Appointment>(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            calendarFormat: _calendarFormat,
            eventLoader: _getAppointmentsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              outsideDaysVisible: false,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: _selectedAppointments.isEmpty
                ? const Center(child: Text('No appointments for this day.'))
                : ListView.builder(
                    itemCount: _selectedAppointments.length,
                    itemBuilder: (context, index) {
                      final appointment = _selectedAppointments[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: ListTile(
                          title: Text(appointment.title),
                          subtitle: Text(
                              '${appointment.startTime.hour}:${appointment.startTime.minute.toString().padLeft(2, '0')} - ${appointment.endTime.hour}:${appointment.endTime.minute.toString().padLeft(2, '0')}'),
                          onTap: () {
                            AppRouter.router.go('${AppRouter.appointmentDetailRoute}/${appointment.id}');
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}