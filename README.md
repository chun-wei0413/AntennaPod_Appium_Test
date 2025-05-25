## AntennaPod Android 自動化測試專案

本專案示範如何結合 **Android Studio**、**Appium**、**Appium Inspector** 與 **Robot Framework**，對 AntennaPod Android 應用程式進行自動化測試。

---

### 一、專案結構

```
AntennaPod/
├── config/
│   ├── settings.robot       # Robot Framework 設定檔
│   └── variables.robot      # 測試變數檔
├── report/                  # 執行測試後自動生成的報告目錄
├── test.robot               # 測試案例主腳本
├── run.bat                  # 一鍵執行測試並生成報告
└── README.md                # 本檔案
```

---

### 二、元件關係說明

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

### 三、環境與安裝

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

### 四、配置說明

* `config/settings.robot`：引入 `AppiumLibrary`
* `config/variables.robot`：定義 Appium Server URL、platformName、automationName、deviceName、appPackage、appActivity

```robot
*** Settings ***
Library    AppiumLibrary

*** Variables ***
${REMOTE_URL}      http://127.0.0.1:4723
${PLATFORM_NAME}   Android
${AUTOMATION_NAME} UiAutomator2
${DEVICE_NAME}     Android
${APP_PACKAGE}     de.danoeh.antennapod.debug
${APP_ACTIVITY}    de.danoeh.antennapod.activity.MainActivity
```

---

### 五、測試案例範例 (test.robot)

以下示範一個「清空播放佇列並驗證空佇列訊息」的完整流程：

```robot
*** Settings ***
Resource    config/settings.robot
Resource    config/variables.robot

*** Test Cases ***
Clear Queue And Assert Empty Message
    [Documentation]    點擊佇列、清除佇列、確認顯示 "No queued episodes"
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
    
    # 點擊下方導航欄「Queue」按鈕 (第二個圖示)
    Click Element    xpath=(//android.widget.FrameLayout[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_container"])[2]
    Wait Until Page Contains Element    xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10s

    # 點選更多選項
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Clear queue"]    timeout=10s

    # 點選 Clear queue
    Click Element    xpath=//android.widget.TextView[@text="Clear queue"]
    # 點擊 Confirm
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]

    # 驗證空佇列文字
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/emptyViewTitle"]    10s
    Element Text Should Be    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/emptyViewTitle"]    No queued episodes

    Close Application
```

---

### 六、執行測試

1. 確保 Appium Server 正常啟動：

   ```bash
   appium --allow-cors
   ```
2. 執行測試並生成報告：

   ```bash
   run.bat
   ```

   或手動：

   ```bash
   robot --outputdir report test.robot
   ```
3. 在 `report/` 目錄中查看 `log.html` 與 `report.html`。

---

### 七、注意事項

* 若定位失敗，可使用 Appium Inspector 重抓 XPath。
* Appium 2.x 不需在 URL 加 `/wd/hub`。
* 測試執行前請先開啟模擬器並安裝 APK。

---

歡迎 pull requests、issue 回報，讓此專案更完善！
