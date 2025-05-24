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
    
    # 點右上角「更多選項」按鈕（三個點）
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]

    Wait Until Page Contains Element    xpath=//android.widget.TextView[@text="Clear queue"]    timeout=10s
    
    # 點選「Clear queue」
    Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Clear queue"]
    
    # 點擊確認對話框上的「Confirm」按鈕
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]
    
    # 驗證畫面出現「No queued episodes」
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/emptyViewTitle"]    10s
    Element Text Should Be    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/emptyViewTitle"]    No queued episodes

    Close Application
