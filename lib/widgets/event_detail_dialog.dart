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
                  Hero(
                    tag: '${event.title}_${event.group}',
                    child: Image.asset(
                      'lib/img/hero.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                  const SizedBox(height: 8),
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
                      Builder(
                        builder: (context) {
                          print('處理欄位: ${fields[i]}');
                          final rawValue = event.data[fields[i]] ?? '';
                          print('原始欄位值: "$rawValue"');
                          
                          // 使用分割再合併的方式清理
                          String value = rawValue
                              .split(RegExp(r'[\s\n\r]+'))  // 用任何空白或換行符號分割
                              .where((s) => s.isNotEmpty)   // 移除空字串
                              .join('');                    // 重新合併
                          
                          print('處理後的欄位值: "$value"');
                          print('處理後的字元編碼: ${value.codeUnits}');
                          if (value.isNotEmpty) {
                            return Padding(
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
                                  if ((fields[i] == 'url' || fields[i] == 'source') && 
                                      value.isNotEmpty &&
                                      value.startsWith('http'))
                                    InkWell(
                                      onTap: () {
                                        print('點擊連結: $value');
                                        html.window.open(value, '_blank');
                                      },
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  else
                                    Text(
                                      value,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                ],
                              ),
                            );
                          }
                          return Container();
                        },
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