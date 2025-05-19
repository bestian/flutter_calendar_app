class Event {
  final String title;  // 事件標題
  final String group;  // 事件所屬組別
  final Map<String, String> data;  // 事件詳細數據

  Event({required this.title, required this.group, required this.data});

  @override
  String toString() => '$group::$title';  // 重寫 toString 方法，用於調試
} 