import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert' show latin1, utf8;
import 'dart:html' as html;
import 'dart:collection';

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CalendarHomePage(),
    );
  }
}

class Event {
  final String title;
  final String group;
  final Map<String, String> data;

  Event({required this.title, required this.group, required this.data});

  @override
  String toString() => '$group::$title';
}

class CalendarHomePage extends StatefulWidget {
  @override
  _CalendarHomePageState createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  final String sourceUrl = 'https://docs.google.com/spreadsheets/d/e/2PACX-1vS-ZZ5igNAgYF2aDKkvNqmY1ia5yv2RMDymvD3qvAJzzVPU5oVoFepzDHva8y6BJWPlkrbrJNKmPlK8/pub?gid=1419688078&single=true&output=csv';
  Map<DateTime, List<Event>> _events = {};
  List<String> _fields = [];
  List<String> _labels = [];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _loadCSV();
  }

  Future<void> _loadCSV() async {
    final client = http.Client();
    try {
      final request = http.Request('GET', Uri.parse(sourceUrl));
      // 添加 Accept-Charset 头确保服务器返回 UTF-8 编码
      request.headers['Accept-Charset'] = 'utf-8';
      
      final streamedResponse = await client.send(request);
      final responseData = await streamedResponse.stream.toBytes();
      
      // 手动将字节解码为 UTF-8 字符串，尝试不同的编码
      String csvString;
      try {
        // 首先尝试 UTF-8 解码
        csvString = utf8.decode(responseData, allowMalformed: false);
      } catch (e) {
        // 如果 UTF-8 失败，尝试使用 Windows-1252 编码（常见于某些 Excel 导出的 CSV）
        try {
          csvString = latin1.decode(responseData);
        } catch (e) {
          // 如果还是失败，尝试使用系统默认编码
          csvString = String.fromCharCodes(responseData);
        }
      }

      print(csvString);
      
      // 使用 csv 包解析 CSV 数据
      final csvTable = const CsvToListConverter(
        eol: '\n',
        fieldDelimiter: ',',
        shouldParseNumbers: false,
        textDelimiter: '"',
      ).convert(csvString);
      
      final fields = List<String>.from(csvTable[0]);
      final labels = List<String>.from(csvTable[1]);
      final dataRows = csvTable.sublist(2);

      Map<DateTime, List<Event>> eventMap = {};

      for (var row in dataRows) {
        Map<String, String> data = {};
        for (int i = 0; i < fields.length; i++) {
          data[fields[i]] = row.length > i ? row[i].toString() : '';
        }

        try {
          final startParts = data['start']!.split('-').map(int.parse).toList();
          final endParts = data['end']!.split('-').map(int.parse).toList();
          DateTime startDate = DateTime(startParts[0], startParts[1], startParts[2]);
          DateTime endDate = DateTime(endParts[0], endParts[1], endParts[2]);

          for (DateTime d = startDate;
              d.isBefore(endDate.add(Duration(days: 1)));
              d = d.add(Duration(days: 1))) {
            eventMap.putIfAbsent(d, () => []);
            eventMap[d]!.add(Event(
              title: data['title'] ?? '',
              group: data['group'] ?? '',
              data: data,
            ));
          }
        } catch (_) {
          // Skip invalid dates
        }
      }

      setState(() {
        _events = eventMap;
        _fields = fields;
        _labels = labels;
      });
    } catch (e) {
      print('Error loading CSV: $e');
      throw Exception("Failed to load CSV data: $e");
    } finally {
      client.close();
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _showEventDetail(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(event.title),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _fields.map((key) {
                final labelIndex = _fields.indexOf(key);
                final label = _labels.length > labelIndex ? _labels[labelIndex] : key;
                final value = event.data[key] ?? '';
                if (key == 'url' && value.startsWith('http')) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: InkWell(
                      child: Text('連結：' + value, style: TextStyle(color: Colors.blue)),
                      onTap: () {
                        html.window.open(value, '_blank');
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('$label: $value'),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('OK')),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('活動月曆')),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            eventLoader: _getEventsForDay,
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView(
              children: _getEventsForDay(_selectedDay ?? _focusedDay).map((event) {
                return ListTile(
                  title: Text(event.title),
                  subtitle: Text(event.group),
                  onTap: () => _showEventDetail(context, event),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
