import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';
import 'dart:convert' show latin1, utf8;
import '../models/event.dart';

class CsvService {
  final String sourceUrl;

  CsvService({required this.sourceUrl});

  Future<Map<String, dynamic>> loadEvents() async {
    final client = http.Client();
    try {
      final request = http.Request('GET', Uri.parse(sourceUrl));
      request.headers['Accept-Charset'] = 'utf-8';
      
      final streamedResponse = await client.send(request);
      final responseData = await streamedResponse.stream.toBytes();
      
      String csvString;
      try {
        csvString = utf8.decode(responseData, allowMalformed: false);
      } catch (e) {
        try {
          csvString = latin1.decode(responseData);
        } catch (e) {
          csvString = String.fromCharCodes(responseData);
        }
      }
      
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
          // 跳過無效的日期格式
        }
      }

      return {
        'events': eventMap,
        'fields': fields,
        'labels': labels,
      };
    } catch (e) {
      print('Error loading CSV: $e');
      throw Exception("Failed to load CSV data: $e");
    } finally {
      client.close();
    }
  }
} 