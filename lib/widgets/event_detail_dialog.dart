import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../models/event.dart';

class EventDetailDialog extends StatelessWidget {
  final Event event;
  final List<String> fields;
  final List<String> labels;

  const EventDetailDialog({
    Key? key,
    required this.event,
    required this.fields,
    required this.labels,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  if (event.group.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        event.group,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < fields.length; i++)
                      if (event.data[fields[i]]?.isNotEmpty ?? false)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                labels[i],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              if ((fields[i] == 'url' || fields[i] == 'source') && event.data[fields[i]]!.isNotEmpty)
                                InkWell(
                                  onTap: () {
                                    html.window.open(event.data[fields[i]]!, '_blank');
                                  },
                                  child: Text(
                                    event.data[fields[i]]!,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  event.data[fields[i]]!,
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                            ],
                          ),
                        ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).dividerColor.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('關閉'),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 