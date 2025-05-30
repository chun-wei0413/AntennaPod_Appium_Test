*** Settings ***
Resource    ../config/settings.robot
Resource    ../config/variables.robot

Test Setup     Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Test Teardown  Close Application

*** Keywords ***
Prepare Queue With One Podcast
    # 點擊右上角「搜尋」按鈕
    Wait Until Page Contains Element    id=de.danoeh.antennapod.debug:id/action_search    timeout=10s
    Click Element    id=de.danoeh.antennapod.debug:id/action_search

    # 等待搜尋欄出現
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/search_src_text    timeout=10

    # 輸入文字 "nba"
    Input Text    id=de.danoeh.antennapod.debug:id/search_src_text    nba

    # 等待並點擊 "Search online" 按鈕
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/actionButton     timeout=10
    Click Element                    id=de.danoeh.antennapod.debug:id/actionButton

    # 等待並點擊 "The Athletic NBA Daily"
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="The Athletic NBA Daily"]    timeout=15
    Click Element                    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="The Athletic NBA Daily"]

    # 等待並點擊 podcast
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="Can the Knicks force game 7?"]    timeout=15
    Click Element                    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="Can the Knicks force game 7?"]

    # 點擊 "Stream" 按鈕
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/butAction1Text    timeout=10
    Click Element                    id=de.danoeh.antennapod.debug:id/butAction1Text

    # 點擊 "Back" icon 退出 該 podcast modal
    Wait Until Element Is Visible    xpath=//android.widget.ImageButton[@content-desc="Back"]    timeout=10
    Click Element                    xpath=//android.widget.ImageButton[@content-desc="Back"]

    # 點擊 "Back" icon 退出 channel modal
    Wait Until Element Is Visible    xpath=//android.widget.ImageButton[@content-desc="Back"]    timeout=10
    Click Element                    xpath=//android.widget.ImageButton[@content-desc="Back"]

Lock Queue
    # 點選右上角功能欄
    Wait Until Element Is Visible     xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10
    Click Element                     xpath=//android.widget.ImageView[@content-desc="More options"]

    # 點選 "Lock queue"
    Wait Until Element Is Visible     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Lock queue"]    timeout=10
    Click Element                     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Lock queue"]

    # 點選 "Lock queue" 按鈕
    Wait Until Element Is Visible     xpath=//android.widget.Button[@resource-id="android:id/button1"]    timeout=10
    Click Element                     xpath=//android.widget.Button[@resource-id="android:id/button1"]

*** Test Cases ***
Queue is empty whten lock queue

    # 點擊 "Queue" 頁面
    Wait Until Element Is Visible     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]     timeout=10
    Click Element                     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]

    # 驗證是否出現 "No queued episodes"
    Wait Until Element Is Visible     id=de.danoeh.antennapod.debug:id/emptyViewTitle    timeout=5
    Element Text Should Be           id=de.danoeh.antennapod.debug:id/emptyViewTitle    No queued episodes

    Lock Queue

    # 驗證是否出現 "Queue locked"
    Wait Until Element Is Visible     id=de.danoeh.antennapod.debug:id/snackbar_text    timeout=5
    Element Text Should Be           id=de.danoeh.antennapod.debug:id/snackbar_text    Queue locked


Queue is Not Empty When Lock Queue
    Prepare Queue With One Podcast

    # 點擊 "Queue" 頁面
    Wait Until Element Is Visible     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]     timeout=10
    Click Element                     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]

    Lock Queue

    # 驗證 "drag handle" 不存在，表示不能移動 podcast 項目
    Page Should Not Contain Element     id=de.danoeh.antennapod.debug:id/drag_handle

