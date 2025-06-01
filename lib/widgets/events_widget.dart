import 'package:flutter/material.dart';
import '../models/event.dart';
import 'event_detail_page.dart';

class EventsWidget extends StatelessWidget {
  final DateTime selectedDay;
  final List<Event> events;
  final List<String> fields;
  final List<String> labels;
  final bool isWideScreen;
  final Event? focusedEvent;

  const EventsWidget({
    Key? key,
    required this.selectedDay,
    required this.events,
    required this.fields,
    required this.labels,
    required this.isWideScreen,
    this.focusedEvent,
  }) : super(key: key);

  void _showEventDetail(BuildContext context, Event event, int index) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 600),
        pageBuilder: (context, animation, secondaryAnimation) => EventDetailPage(
          event: event,
          fields: fields,
          labels: labels,
          heroTag: '${event.title}_${event.group}_$index',
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: isWideScreen ? 500 : 400,
      ),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
              ),
              child: Text(
                '${selectedDay.year}年${selectedDay.month}月${selectedDay.day}日 的活動',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              child: events.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('當天沒有活動', style: TextStyle(color: Colors.grey)),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        final event = events[index];
                        return Card(
                          color: event.getCategoryColor(),
                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            side: event == focusedEvent
                                ? BorderSide(color: Theme.of(context).primaryColor, width: 4.0)
                                : BorderSide.none,
                          ),
                          child: InkWell(
                            onTap: () => _showEventDetail(context, event, index),
                            borderRadius: BorderRadius.circular(4.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: '${event.title}_${event.group}_$index',
                                    child: Image.asset(
                                      'lib/img/hero.png',
                                      width: 36,
                                      height: 36
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          event.title,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        if (event.group.isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              event.group,
                                              style: TextStyle(
                                                fontSize: 13.0,
                                                color: Theme.of(context).textTheme.bodySmall?.color,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
} 