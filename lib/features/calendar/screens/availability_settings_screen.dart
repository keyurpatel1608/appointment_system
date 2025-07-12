import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/user_provider.dart'; // Assuming availability is tied to user
import 'package:appointment_system/core/models/user_model.dart'; // Assuming user model has availability fields
import 'package:appointment_system/core/utils/date_utils.dart';

class AvailabilitySettingsScreen extends StatefulWidget {
  const AvailabilitySettingsScreen({super.key});

  @override
  State<AvailabilitySettingsScreen> createState() => _AvailabilitySettingsScreenState();
}

class _AvailabilitySettingsScreenState extends State<AvailabilitySettingsScreen> {
  // Example: Store daily availability as a map of DayOfWeek to list of TimeOfDay ranges
  final Map<int, List<TimeOfDay>> _dailyAvailability = {
    DateTime.monday: [],
    DateTime.tuesday: [],
    DateTime.wednesday: [],
    DateTime.thursday: [],
    DateTime.friday: [],
    DateTime.saturday: [],
    DateTime.sunday: [],
  };

  @override
  void initState() {
    super.initState();
    _loadAvailability();
  }

  void _loadAvailability() {
    // In a real app, load this from user preferences or a backend service
    // For now, populate with some dummy data
    setState(() {
      _dailyAvailability[DateTime.monday] = [const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0)];
      _dailyAvailability[DateTime.tuesday] = [const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0)];
      _dailyAvailability[DateTime.wednesday] = [const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0)];
      _dailyAvailability[DateTime.thursday] = [const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0)];
      _dailyAvailability[DateTime.friday] = [const TimeOfDay(hour: 9, minute: 0), const TimeOfDay(hour: 17, minute: 0)];
    });
  }

  Future<void> _selectTimeRange(BuildContext context, int day) async {
    final TimeOfDay? start = await showTimePicker(
      context: context,
      initialTime: _dailyAvailability[day]!.isNotEmpty ? _dailyAvailability[day]![0] : TimeOfDay.now(),
      helpText: 'Select Start Time',
    );
    if (start == null) return;

    final TimeOfDay? end = await showTimePicker(
      context: context,
      initialTime: _dailyAvailability[day]!.length > 1 ? _dailyAvailability[day]![1] : TimeOfDay.now(),
      helpText: 'Select End Time',
    );
    if (end == null) return;

    if (start.hour > end.hour || (start.hour == end.hour && start.minute >= end.minute)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('End time cannot be before or same as start time.')),
      );
      return;
    }

    setState(() {
      _dailyAvailability[day] = [start, end];
    });
  }

  void _saveAvailability() {
    // In a real app, save this data to your backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Availability settings saved!')), 
    );
    // You might want to update the UserProvider or a dedicated CalendarProvider here
  }

  String _getDayName(int day) {
    switch (day) {
      case DateTime.monday: return 'Monday';
      case DateTime.tuesday: return 'Tuesday';
      case DateTime.wednesday: return 'Wednesday';
      case DateTime.thursday: return 'Thursday';
      case DateTime.friday: return 'Friday';
      case DateTime.saturday: return 'Saturday';
      case DateTime.sunday: return 'Sunday';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Availability Settings'),
      ),
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          final day = index + 1; // DateTime.monday is 1, Sunday is 7
          final times = _dailyAvailability[day]!;
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(_getDayName(day)),
              subtitle: times.isEmpty
                  ? const Text('Not Available')
                  : Text('${times[0].format(context)} - ${times[1].format(context)}'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _selectTimeRange(context, day),
              ),
              onTap: () => _selectTimeRange(context, day),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _saveAvailability,
        label: const Text('Save Availability'),
        icon: const Icon(Icons.save),
      ),
    );
  }
}