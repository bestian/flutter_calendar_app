import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:math' show min;
import '../models/event.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final List<Event> Function(DateTime) eventLoader;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final bool isWideScreen;

  const CalendarWidget({
    Key? key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.eventLoader,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.isWideScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isWideScreen ? 500 : 400,
      ),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: focusedDay,
            calendarFormat: calendarFormat,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            eventLoader: eventLoader,
            onDaySelected: onDaySelected,
            onFormatChanged: onFormatChanged,
            calendarStyle: CalendarStyle(
              cellPadding: const EdgeInsets.all(1.0),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return Container(
                  margin: const EdgeInsets.all(1.0),
                  alignment: Alignment.center,
                  child: Text(
                    '${day.day}',
                    style: const TextStyle(fontSize: 12.0),
                  ),
                );
              },
              markerBuilder: (context, date, events) {
                if (events.isEmpty) return null;
                final displayEvents = events.take(1).toList();
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: displayEvents.map((event) {
                    final cleanTitle = event.title.replaceFirst(RegExp(r'^\d+'), '');
                    final title = cleanTitle.isEmpty 
                        ? event.title.substring(0, min(5, event.title.length))
                        : (cleanTitle.length > 5 
                            ? '${cleanTitle.substring(0, 5)}...' 
                            : cleanTitle);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: isWideScreen ? 10 : 9,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
} 