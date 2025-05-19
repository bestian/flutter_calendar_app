import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/event.dart';
import '../services/csv_service.dart';
import '../widgets/banner_widget.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/events_widget.dart';

class CalendarHomePage extends StatefulWidget {
  const CalendarHomePage({Key? key}) : super(key: key);

  @override
  State<CalendarHomePage> createState() => _CalendarHomePageState();
}

class _CalendarHomePageState extends State<CalendarHomePage> {
  late DateTime _focusedDay;
  late DateTime? _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<Event>> _events = {};
  late List<String> _fields = [];
  late List<String> _labels = [];
  late bool _isLoading = true;
  late String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final csvService = CsvService(
        sourceUrl: 'https://docs.google.com/spreadsheets/d/e/2PACX-1vQj8i_8c6NCNB6yjur6K47psT0lPe2_rdhoR5p8lZxBNBy0osu4feoRf3Y5Q5uJzNYKwFfHPgmmf/pub?gid=1419688078&single=true&output=csv',
      );

      final result = await csvService.loadEvents();
      setState(() {
        _events = result['events'] as Map<DateTime, List<Event>>;
        _fields = result['fields'] as List<String>;
        _labels = result['labels'] as List<String>;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = '載入資料時發生錯誤：$e';
        _isLoading = false;
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('營隊月曆'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadEvents,
            tooltip: '重新載入',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _errorMessage,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _loadEvents,
                          child: const Text('重試'),
                        ),
                      ],
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BannerWidget(),
                      Container(
                        constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 200,
                        ),
                        child: isWideScreen
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: CalendarWidget(
                                      focusedDay: _focusedDay,
                                      selectedDay: _selectedDay,
                                      calendarFormat: _calendarFormat,
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
                                      isWideScreen: isWideScreen,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: EventsWidget(
                                      selectedDay: _selectedDay!,
                                      events: _getEventsForDay(_selectedDay!),
                                      fields: _fields,
                                      labels: _labels,
                                      isWideScreen: isWideScreen,
                                    ),
                                  ),
                                ],
                              )
                            : DefaultTabController(
                                length: 2,
                                child: Column(
                                  children: [
                                    Container(
                                      constraints: const BoxConstraints(
                                        minHeight: 500,
                                      ),
                                      child: CalendarWidget(
                                        focusedDay: _focusedDay,
                                        selectedDay: _selectedDay,
                                        calendarFormat: _calendarFormat,
                                        eventLoader: _getEventsForDay,
                                        onDaySelected: (selectedDay, focusedDay) {
                                          setState(() {
                                            _selectedDay = selectedDay;
                                            _focusedDay = focusedDay;
                                          });
                                          if (_getEventsForDay(selectedDay).isNotEmpty) {
                                            DefaultTabController.of(context).animateTo(1);
                                          }
                                        },
                                        onFormatChanged: (format) {
                                          setState(() {
                                            _calendarFormat = format;
                                          });
                                        },
                                        isWideScreen: isWideScreen,
                                      ),
                                    ),
                                    const TabBar(
                                      tabs: [
                                        Tab(text: '月曆'),
                                        Tab(text: '活動列表'),
                                      ],
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(
                                        minHeight: 500,
                                      ),
                                      child: TabBarView(
                                        children: [
                                          const SizedBox.shrink(),
                                          EventsWidget(
                                            selectedDay: _selectedDay!,
                                            events: _getEventsForDay(_selectedDay!),
                                            fields: _fields,
                                            labels: _labels,
                                            isWideScreen: isWideScreen,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
    );
  }
} 