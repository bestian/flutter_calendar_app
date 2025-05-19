import 'package:flutter/material.dart';

class Event {
  final String title;  // 事件標題
  final String group;  // 事件所屬組別
  final String category;  // 事件類別
  final Map<String, String> data;  // 事件詳細數據

  Event({required this.title, required this.group, required this.category, required this.data});

  @override
  String toString() => '$group::$title';  // 重寫 toString 方法，用於調試

  Color getCategoryColor() {
    switch (category) {
      case '戶外':
        return Colors.lightGreen.shade300;
      case '科學':
        return Colors.blue.shade300;
      case '運動':
        return Colors.orange.shade300;
      case '美學':
        return Colors.purple.shade200;
      case '生物':
        return Colors.teal.shade200;
      case '靜心':
        return Colors.pink.shade100;
      default:
        return Colors.grey.shade200;
    }
  }
}