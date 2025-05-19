# flutter_calendar_app

A new Flutter project.



## 本地開發與測試

### Chrome 版本測試
1. 確保已安裝 Flutter 開發環境
2. 在專案根目錄執行以下命令：
   ```bash
   flutter run -d chrome
   ```
3. 等待編譯完成後，Chrome 瀏覽器會自動開啟應用程式
4. 開發時修改程式碼後，在終端機按「r」會自動熱重載（Hot Reload）

### 部署
1. 確保已安裝 Flutter 開發環境
2. 在專案根目錄執行部署腳本：
   ```bash
   sh deploy.sh
   ```
3. 部署腳本會自動執行以下步驟：
   - 建置網頁版本（Web Build）
   - 優化資源
   - 部署到指定伺服器

注意：部署前請確保：
- 已正確設定部署環境變數
- 有適當的伺服器存取權限
- 已備份重要資料


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

