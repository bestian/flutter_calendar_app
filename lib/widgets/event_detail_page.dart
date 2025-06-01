import 'package:flutter/material.dart';
import 'dart:html' as html;
import '../models/event.dart';

class EventDetailPage extends StatelessWidget {
  final Event event;
  final List<String> fields;
  final List<String> labels;
  final String heroTag;

  const EventDetailPage({
    Key? key,
    required this.event,
    required this.fields,
    required this.labels,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: heroTag,
                child: Image.asset(
                  'lib/img/hero.png',
                  width: 80,
                  height: 80,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              event.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (event.group.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  event.group,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            const Divider(height: 24),
            ...[for (int i = 0; i < fields.length; i++)
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
                      if ((fields[i] == 'url' || fields[i] == 'source') && event.data[fields[i]]!.startsWith('http'))
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('關閉'),
          ),
        ),
      ),
    );
  }
} 