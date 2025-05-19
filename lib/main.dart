// 導入必要的 Flutter 和 Dart 庫
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // 用於發送 HTTP 請求
import 'package:csv/csv.dart';  // 用於解析 CSV 數據
import 'package:table_calendar/table_calendar.dart';  // 日曆組件
import 'dart:convert' show latin1, utf8;  // 字符編碼轉換
import 'dart:html' as html;  // 網頁相關功能
import 'dart:collection';  // 集合工具類

// 應用程序入口
void main() {
  runApp(CalendarApp());  // 啟動日曆應用
}

// 主應用組件
class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',  // 應用標題
      theme: ThemeData(primarySwatch: Colors.blue),  // 主題顏色
      home: CalendarHomePage(),  // 主頁面
    );
  }
}

// 事件數據模型
class Event {
  final String title;  // 事件標題
  final String group;  // 事件所屬組別
  final Map<String, String> data;  // 事件詳細數據

  Event({required this.title, required this.group, required this.data});

  @override
  String toString() => '$group::$title';  // 重寫 toString 方法，用於調試
}

// 日曆主頁面（有狀態組件）
class CalendarHomePage extends StatefulWidget {
  @override
  _CalendarHomePageState createState() => _CalendarHomePageState();
}

// 日曆主頁面的狀態類
class _CalendarHomePageState extends State<CalendarHomePage> {
  // Google Sheets 數據源 URL
  final String sourceUrl = 'https://docs.google.com/spreadsheets/d/e/2PACX-1vS-ZZ5igNAgYF2aDKkvNqmY1ia5yv2RMDymvD3qvAJzzVPU5oVoFepzDHva8y6BJWPlkrbrJNKmPlK8/pub?gid=1419688078&single=true&output=csv';
  
  // 存儲事件數據，鍵為日期，值為該日期的事件列表
  Map<DateTime, List<Event>> _events = {};
  
  // CSV 文件的字段名和顯示標籤
  List<String> _fields = [];  // 字段名
  List<String> _labels = [];  // 顯示標籤
  
  // 日曆相關狀態
  DateTime _focusedDay = DateTime.now();  // 當前聚焦的日期
  DateTime? _selectedDay;  // 選中的日期
  CalendarFormat _calendarFormat = CalendarFormat.month;  // 日曆視圖格式（月/周/日）

  @override
  void initState() {
    super.initState();
    _loadCSV();  // 組件初始化時加載 CSV 數據
  }

  // 從遠程加載 CSV 數據
  Future<void> _loadCSV() async {
    final client = http.Client();  // 創建 HTTP 客戶端
    try {
      // 創建 GET 請求
      final request = http.Request('GET', Uri.parse(sourceUrl));
      // 添加請求頭，指定接受 UTF-8 編碼
      request.headers['Accept-Charset'] = 'utf-8';
      
      // 發送請求並獲取響應
      final streamedResponse = await client.send(request);
      final responseData = await streamedResponse.stream.toBytes();
      
      // 處理不同編碼的 CSV 數據
      String csvString;
      try {
        // 首先嘗試 UTF-8 解碼（最常見的編碼）
        csvString = utf8.decode(responseData, allowMalformed: false);
      } catch (e) {
        // 如果 UTF-8 解碼失敗，嘗試使用 Windows-1252 編碼
        // 這在處理某些 Excel 導出的 CSV 文件時可能需要
        try {
          csvString = latin1.decode(responseData);
        } catch (e) {
          // 如果所有解碼方式都失敗，使用默認方式處理
          csvString = String.fromCharCodes(responseData);
        }
      }

      // 打印 CSV 原始數據（調試用）
      print(csvString);
      
      // 使用 csv 包解析 CSV 數據
      final csvTable = const CsvToListConverter(
        eol: '\n',  // 行結束符
        fieldDelimiter: ',',  // 字段分隔符
        shouldParseNumbers: false,  // 不自動解析數字
        textDelimiter: '"',  // 文本限定符
      ).convert(csvString);
      
      // 解析 CSV 表頭和數據行
      final fields = List<String>.from(csvTable[0]);  // 第一行是字段名
      final labels = List<String>.from(csvTable[1]);  // 第二行是顯示標籤
      final dataRows = csvTable.sublist(2);  // 剩餘行是數據

      // 創建事件映射，按日期組織事件
      Map<DateTime, List<Event>> eventMap = {};

      // 處理每一行數據
      for (var row in dataRows) {
        // 將行數據轉換為鍵值對
        Map<String, String> data = {};
        for (int i = 0; i < fields.length; i++) {
          data[fields[i]] = row.length > i ? row[i].toString() : '';
        }

        try {
          // 解析開始和結束日期
          final startParts = data['start']!.split('-').map(int.parse).toList();
          final endParts = data['end']!.split('-').map(int.parse).toList();
          
          // 創建日期對象
          DateTime startDate = DateTime(startParts[0], startParts[1], startParts[2]);
          DateTime endDate = DateTime(endParts[0], endParts[1], endParts[2]);

          // 為日期範圍內的每一天創建事件
          for (DateTime d = startDate;
              d.isBefore(endDate.add(Duration(days: 1)));
              d = d.add(Duration(days: 1))) {
            // 如果該日期還沒有事件列表，創建一個新的空列表
            eventMap.putIfAbsent(d, () => []);
            // 添加事件到對應日期的列表
            eventMap[d]!.add(Event(
              title: data['title'] ?? '',  // 事件標題
              group: data['group'] ?? '',  // 事件組別
              data: data,  // 事件詳細數據
            ));
          }
        } catch (_) {
          // 跳過無效的日期格式
        }
      }

      // 更新狀態，觸發 UI 重新構建
      setState(() {
        _events = eventMap;  // 更新事件數據
        _fields = fields;   // 更新字段名
        _labels = labels;   // 更新顯示標籤
      });
    } catch (e) {
      // 處理加載錯誤
      print('Error loading CSV: $e');
      throw Exception("Failed to load CSV data: $e");
    } finally {
      client.close();  // 確保關閉 HTTP 客戶端
    }
  }

  // 獲取指定日期的事件列表
  List<Event> _getEventsForDay(DateTime day) {
    // 返回該日期的事件列表，如果沒有則返回空列表
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }

  // 顯示事件詳情對話框
  void _showEventDetail(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(event.title),  // 對話框標題顯示事件標題
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // 左對齊
              children: _fields.map((key) {
                // 獲取字段的顯示標籤，如果沒有則使用字段名
                final labelIndex = _fields.indexOf(key);
                final label = _labels.length > labelIndex ? _labels[labelIndex] : key;
                // 獲取字段值
                final value = event.data[key] ?? '';
                
                // 特殊處理 URL 字段，使其可點擊
                if (key == 'url' && value.startsWith('http')) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: InkWell(
                      child: Text('連結：' + value, style: TextStyle(color: Colors.blue)),
                      onTap: () {
                        // 在新標籤頁中打開鏈接
                        html.window.open(value, '_blank');
                        // 關閉對話框
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                }
                
                // 顯示普通字段
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text('$label: $value'),
                );
              }).toList(),
            ),
          ),
          // 對話框操作按鈕
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('OK')
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 應用欄
      appBar: AppBar(title: Text('活動月曆')),
      
      // 主體內容
      body: Column(
        children: [
          // 日曆組件
          TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),  // 可選的最早日期
            lastDay: DateTime.utc(2030, 12, 31),  // 可選的最晚日期
            focusedDay: _focusedDay,  // 當前聚焦的日期
            calendarFormat: _calendarFormat,  // 日曆視圖格式
            
            // 判斷某天是否被選中
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            
            // 加載某天的事件
            eventLoader: _getEventsForDay,
            
            // 處理日期選擇
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;  // 更新選中日期
                _focusedDay = focusedDay;    // 更新聚焦日期
              });
            },
            
            // 處理視圖格式變化
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;  // 更新日曆視圖格式
              });
            },
            
            // 日曆樣式
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange, 
                shape: BoxShape.circle
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue, 
                shape: BoxShape.circle
              ),
            ),
          ),
          
          // 間距
          const SizedBox(height: 8.0),
          
          // 事件列表
          Expanded(
            child: ListView(
              // 顯示選中日期的所有事件
              children: _getEventsForDay(_selectedDay ?? _focusedDay).map((event) {
                return ListTile(
                  title: Text(event.title),  // 事件標題
                  subtitle: Text(event.group),  // 事件組別
                  onTap: () => _showEventDetail(context, event),  // 點擊顯示詳情
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
