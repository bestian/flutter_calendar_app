import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:html' as html;

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      color: Colors.blue[50],
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black87, fontSize: 14, height: 1.5),
          children: [
            TextSpan(text: '💪 優質營隊資訊，直接'),
            TextSpan(
              text: '編輯表單',
              style: TextStyle(
                color: Colors.blue[700],
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  html.window.open(
                    'https://docs.google.com/spreadsheets/d/1AdMAE1buc3jZbdBgMyKzv0oND3qfW-my_yZAOgrG1hk/edit?hl=zh-tw&gid=1419688078#gid=1419688078',
                    '_blank',
                  );
                },
            ),
            TextSpan(text: '，會呈現在月曆。\n'),
            TextSpan(text: '🦾 用AI服務更方便填寫: '),
            TextSpan(
              text: '說明文件',
              style: TextStyle(
                color: Colors.blue[700],
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  html.window.open(
                    'https://hackmd.io/@moogoo/Hk2en_oxee',
                    '_blank',
                  );
                },
            ),
            TextSpan(text: '。\n'),
            TextSpan(text: '感謝'),
            TextSpan(
              text: 'moogoo原作的"父母救星 - 營隊月曆"',
              style: TextStyle(
                color: Colors.blue[700],
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  html.window.open(
                    'https://moogoo78.github.io/summer-cal/',
                    '_blank',
                  );
                },
            ),
            TextSpan(text: '。\n'),
            TextSpan(text: '本站'),
            TextSpan(
              text: '原始碼',
              style: TextStyle(
                color: Colors.blue[700],
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  html.window.open(
                    'https://github.com/bestian/flutter_calendar_app',
                    '_blank',
                  );
                },
            ),
            TextSpan(text: '為參考原作，重新設計的版本。'),
          ],
        ),
      ),
    );
  }
} 