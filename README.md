## AntennaPod Android 自動化測試專案

本專案示範如何結合 **Android Studio**、**Appium**、**Appium Inspector** 與 **Robot Framework**，對 AntennaPod Android 應用程式進行自動化測試。

---

### 一、元件關係說明

1. **Android Studio**

   * 用於開發與編譯 AntennaPod Android 應用。
   * 透過模擬器或真機啟動 APK，供 Appium 進行自動化測試。

2. **Appium**

   * 一個跨平台自動化測試伺服器，支援 Android 與 iOS。
   * 本專案使用 Appium 2.x 與 `uiautomator2` 驅動（automationName: UiAutomator2）
   * 啟動指令：

     ```bash
     appium --allow-cors
     ```

3. **Appium Inspector**

   * 一個 GUI 工具，用於在真機/模擬器中檢視 UI 元素結構 (XPath, resource-id, content-desc 等)。
   * 幫助產生穩定的定位策略，並驗證元素是否可被 Appium 探測。

4. **Robot Framework**

   * 關鍵字驅動的自動化測試框架。
   * 使用 `robotframework-appiumlibrary` 整合 Appium 作為底層執行引擎。
   * 測試案例撰寫於 `*.robot` 檔案，語法簡潔易讀。

---

### 二、環境與安裝

1. 安裝 Android Studio，並建立或匯入 AntennaPod 專案。
2. 用 Android Studio 編譯並安裝 `de.danoeh.antennapod.debug` 到模擬器或真機。
3. 安裝 Appium 與驅動：

   ```bash
   npm install -g appium
   appium driver install uiautomator2
   ```
4. 安裝 Appium Inspector（可從 Appium Desktop 下載）。
5. 安裝 Python 與 Robot Framework：

   ```bash
   pip install robotframework
   pip install robotframework-appiumlibrary
   ```

---


### 三、執行測試

1. 確保 Appium Server 正常啟動：

   ```bash
   appium --allow-cors
   ```
2. 到目標目錄底下:
   ```
   ___test_script
      |
      |___UC-FP
      |   |
      |   |___UC-FP.robot
      |   
      |___UC-MC
      |   |
      |   |___UC-MC.robot
      |
      |___UC-QC
      |   |
      |   |___UC-QC.robot
      |
      |___UC-SM
          |
          |__UC-SM.robot

   ```
3. 執行測試並生成報告：

   ```bash
   robot --outputdir report UC-FP.robot
   ```

   ```bash
   robot --outputdir report UC-MC.robot
   ```

   ```bash
   robot --outputdir report UC-QC.robot
   ```

   ```bash
   robot --outputdir report UC-SM.robot
   ```

3. 在 `report/` 目錄中查看 `log.html` 與 `report.html`。

---

### 四、注意事項

* 若定位失敗，可使用 Appium Inspector 重抓 XPath。
* Appium 2.x 不需在 URL 加 `/wd/hub`。
* 測試執行前請先開啟模擬器並安裝 APK。

---
