// 導入必要的 Flutter 和 Dart 庫
import 'models/event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;  // 用於發送 HTTP 請求
import 'package:csv/csv.dart';  // 用於解析 CSV 數據
import 'package:table_calendar/table_calendar.dart';  // 日曆組件
import 'dart:convert' show latin1, utf8;  // 字符編碼轉換
import 'dart:html' as html;  // 網頁相關功能
import 'dart:collection';  // 集合工具類
import 'dart:math' show min;  // 數學函數
import 'package:flutter/gestures.dart';  // 用於手勢識別
import 'widgets/events_widget.dart';
import 'widgets/banner_widget.dart';
import 'widgets/search_widget.dart';

// 應用程序入口
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '營隊月曆',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: CalendarHomePage(),
    );
  }
}

// 日曆主頁面（有狀態組件）
class CalendarHomePage extends StatefulWidget {
  @override
  _CalendarHomePageState createState() => _CalendarHomePageState();
}

// 日曆主頁面的狀態類
class _CalendarHomePageState extends State<CalendarHomePage> with SingleTickerProviderStateMixin {
  // 添加 TabController
  late TabController _tabController;
  Event? _focusedEvent;  // 添加這行

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
    _tabController = TabController(length: 2, vsync: this);
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _loadCSV();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      // print(csvString);
      
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
          
          // 創建日期對象，並標準化為當天開始時間
          DateTime startDate = DateTime(startParts[0], startParts[1], startParts[2]);
          DateTime endDate = DateTime(endParts[0], endParts[1], endParts[2]);

          // 調試日誌：打印事件信息
          print('處理事件: ${data['title']}');
          print('開始日期: $startDate');
          print('結束日期: $endDate');

          // 檢查日期是否有效
          if (startDate.isAfter(endDate)) {
            print('警告：開始日期晚於結束日期，跳過此事件');
            continue;
          }

          // 檢查日期範圍是否合理（不超過一年）
          if (endDate.difference(startDate).inDays > 365) {
            print('警告：事件持續時間超過一年，跳過此事件');
            continue;
          }

          // 使用更安全的方式處理日期範圍
          DateTime currentDate = startDate;
          int count = 0;
          const maxDays = 366; // 最大允許天數（包含閏年）

          while (currentDate.isBefore(endDate.add(const Duration(days: 1))) && count < maxDays) {
            // 創建標準化的日期（只保留年月日）
            final normalizedDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
            print('添加事件到日期: $normalizedDate (第 ${count + 1} 天)');

            // 如果該日期還沒有事件列表，創建一個新的空列表
            eventMap.putIfAbsent(normalizedDate, () => []);
            
            // 添加事件到對應日期的列表
            eventMap[normalizedDate]!.add(Event(
              title: data['title'] ?? '',
              group: data['group'] ?? '',
              category: data['categories']?.split(',').first ?? '',
              data: data,
            ));

            // 移動到下一天
            currentDate = currentDate.add(const Duration(days: 1));
            count++;

            // 安全檢查：如果超過最大天數，強制退出
            if (count >= maxDays) {
              print('警告：達到最大天數限制，停止添加事件');
              break;
            }
          }

          print('事件 ${data['title']} 添加完成，共添加 $count 天');
        } catch (e) {
          // 打印錯誤信息
          print('處理事件時出錯: ${data['title']}');
          print('錯誤詳情: $e');
          // 跳過無效的日期格式
          continue;
        }
      }

      // 調試日誌：打印最終的事件映射
      print('最終事件映射:');
      eventMap.forEach((date, events) {
        print('日期 $date: ${events.map((e) => e.title).join(', ')}');
      });

      // 更新狀態，觸發 UI 重新構建
      setState(() {
        _events = eventMap;
        _fields = fields;
        _labels = labels;
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

  // 獲取所有事件
  List<Event> get _allEvents {
    return _events.values.expand((events) => events).toList();
  }

  // 處理搜尋結果選擇
  void _handleSearchResultSelected(Event event) {
    // 找到事件的第一個日期
    final eventDate = _events.entries
        .firstWhere((entry) => entry.value.contains(event))
        .key;
    print('eventDate: $eventDate');
    
    setState(() {
      _selectedDay = eventDate;
      _focusedDay = eventDate;
      _focusedEvent = event;
    });

    // 使用 Future.microtask 確保在 setState 之後執行
    Future.microtask(() {
      final isWideScreen = MediaQuery.of(context).size.width > 800;
      print('isWideScreen: $isWideScreen');
      
      if (!isWideScreen) {
        _tabController.animateTo(1);
      }
    });
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
      appBar: AppBar(
        title: const Text('營隊月曆'),
        backgroundColor: Colors.blue,  // 添加背景色
        foregroundColor: Colors.white,  // 添加前景色
        actions: [
          // 搜尋按鈕
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: const Icon(Icons.search, size: 28),  // 加大圖示
              tooltip: '搜尋活動',  // 添加提示文字
              onPressed: () {
                print('搜尋按鈕被點擊');  // 添加調試日誌
                showDialog(
                  context: context,
                  barrierDismissible: true,  // 允許點擊外部關閉
                  builder: (context) => Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.8,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '搜尋活動',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.close, size: 28),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                          const Divider(height: 24),
                          Expanded(
                            child: SearchWidget(
                              allEvents: _allEvents,
                              onEventSelected: (event) {
                                Navigator.of(context).pop();
                                _handleSearchResultSelected(event);
                              },
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
      // 主體內容
      body: Column(
        children: [
          // 頂部橫幅
          BannerWidget(),
          // 主要內容
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
          // 判斷是否為寬螢幕（寬度大於 800 像素）
          final isWideScreen = constraints.maxWidth > 800;
          
          // 如果是寬螢幕，使用橫向排列；否則使用縱向排列
          final mainAxis = isWideScreen ? Axis.horizontal : Axis.vertical;
          
          // 寬螢幕維持 Flex，窄螢幕用 Tab 切換日曆/細節
          if (isWideScreen) {
            return Flex(
              direction: mainAxis,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              children: [
                // 日曆組件 - 在寬螢幕上佔用 60% 的寬度，窄螢幕上佔用 100% 的寬度，確保高度夠高
                Flexible(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      constraints: const BoxConstraints(), // 寬螢幕不限制高度
                      
                      child: Builder(
                        builder: (tabContext) => TableCalendar<Event>(
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
                            final isWideScreen = MediaQuery.of(tabContext).size.width > 800;
                            if (!isWideScreen && _getEventsForDay(selectedDay).isNotEmpty) {
                              _tabController.animateTo(1);
                            }
                          },
                          onFormatChanged: (format) {
                            setState(() {
                              _calendarFormat = format;
                            });
                          },
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
                                        fontSize: 10,
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
                  ),
                ),
                // 間距 - 只在寬螢幕時顯示垂直分隔線
                VerticalDivider(width: 1, thickness: 1, color: Colors.grey[300]),
                // 事件列表 - 在寬螢幕上佔用 40% 的寬度
                Flexible(
                  flex: 4,
                  child: EventsWidget(
                    selectedDay: _selectedDay ?? _focusedDay,
                    events: _getEventsForDay(_selectedDay ?? _focusedDay),
                    isWideScreen: isWideScreen,
                    fields: _fields,
                    labels: _labels,
                    focusedEvent: _focusedEvent,
                  ),
                ),
              ],
            );
          } else {
            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(icon: Icon(Icons.calendar_today), text: '日曆'),
                    Tab(icon: Icon(Icons.list), text: '活動'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // 日曆 Tab
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 500),
                          child: Builder(
                            builder: (tabContext) => TableCalendar<Event>(
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
                                final isWideScreen = MediaQuery.of(context).size.width > 800;
                                if (!isWideScreen && _getEventsForDay(selectedDay).isNotEmpty) {
                                  _tabController.animateTo(1);
                                }
                              },
                              onFormatChanged: (format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              },
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
                                            fontSize: 9,
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
                      ),
                      // 活動 Tab
                      EventsWidget(
                        selectedDay: _selectedDay ?? _focusedDay,
                        events: _getEventsForDay(_selectedDay ?? _focusedDay),
                        isWideScreen: false,
                        fields: _fields,
                        labels: _labels,
                        focusedEvent: _focusedEvent,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
              },
            ),
          ),
        ],
      ),
    );
  }
}
