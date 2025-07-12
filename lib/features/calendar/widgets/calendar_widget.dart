import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarWidget extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final CalendarFormat calendarFormat;
  final Map<DateTime, List<dynamic>> events;

  const CustomCalendarWidget({
    super.key,
    required this.focusedDay,
    this.selectedDay,
    required this.onDaySelected,
    required this.onFormatChanged,
    this.calendarFormat = CalendarFormat.month,
    this.events = const {},
  });

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: widget.focusedDay,
      selectedDayPredicate: (day) => isSameDay(widget.selectedDay, day),
      calendarFormat: widget.calendarFormat,
      eventLoader: (day) => widget.events[day] ?? [],
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: widget.onDaySelected,
      onFormatChanged: widget.onFormatChanged,
      calendarStyle: const CalendarStyle(
        outsideDaysVisible: false,
      ),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
      ),
    );
  }
}