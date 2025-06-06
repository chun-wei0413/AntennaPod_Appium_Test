*** Settings ***
Library    AppiumLibrary
Library    Process
Library    Collections

*** Variables ***
${REMOTE_URL}          http://127.0.0.1:4723
${PLATFORM_NAME}       Android
${AUTOMATION_NAME}     UiAutomator2
${DEVICE_NAME}         Android
${APP_PACKAGE}         de.danoeh.antennapod.debug
${APP_ACTIVITY}        de.danoeh.antennapod.activity.MainActivity

${PODCAST_TITLE_1}    Haliburton & Pacers shock Thunder in Game 1
${PODCAST_TITLE_2}    NBA Finals Mailbag: Morning Shoot Around
${PODCAST_TITLE_3}    NBA Finals Game 1 Preview

*** Keywords ***
Open AntennaPod
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}   deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}

Teardown And Clear App
    Run Process    adb    shell    pm clear ${APP_PACKAGE}
    Sleep    1s
    Close Application

Add Episode To Queue
    [Arguments]    @{titles}
    # 點擊右上角「搜尋」按鈕
    Wait Until Page Contains Element    id=de.danoeh.antennapod.debug:id/action_search    timeout=10s
    Click Element    id=de.danoeh.antennapod.debug:id/action_search

    # 等待搜尋欄出現
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/search_src_text    timeout=10s

    # 輸入文字 "nba"
    Input Text    id=de.danoeh.antennapod.debug:id/search_src_text    nba

    # 等待並點擊 "Search online" 按鈕
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/actionButton    timeout=10s
    Click Element    id=de.danoeh.antennapod.debug:id/actionButton

    # 點擊 Podcast 頻道 "The Athletic NBA Daily"
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="The Athletic NBA Daily"]    timeout=20s
    Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="The Athletic NBA Daily"]

    # 遍歷傳入的標題，依次選擇 Podcast
    FOR    ${title}    IN    @{titles}
        # 等待並點擊目標 Podcast
        Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]    timeout=10s
        Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]

        # 點擊 "Stream" 按鈕
        Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/butAction1Text    timeout=10s
        Click Element    id=de.danoeh.antennapod.debug:id/butAction1Text

        # 點擊 "Back" icon 退出 Podcast modal
        Wait Until Element Is Visible    xpath=//android.widget.ImageButton[@content-desc="Back"]    timeout=10s
        Click Element    xpath=//android.widget.ImageButton[@content-desc="Back"]
    END

    # 返回到主界面
    Wait Until Element Is Visible    xpath=//android.widget.ImageButton[@content-desc="Back"]    timeout=10s
    Click Element    xpath=//android.widget.ImageButton[@content-desc="Back"]

Go To Queue Page
    Wait Until Element Is Visible    xpath=//android.widget.FrameLayout[@content-desc="Queue"]    timeout=10s
    Click Element    xpath=//android.widget.FrameLayout[@content-desc="Queue"]

Open Sort Menu
    Wait Until Element Is Visible    xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10s
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]    timeout=10s
    Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]

Select Episode Title Sort
    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]    timeout=10s
    Click Element    xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]

Close Sort Menu
    Click Element    xpath=//android.view.View[@resource-id="de.danoeh.antennapod.debug:id/touch_outside"]
#Queue Management Keywords
Lock Queue
    Wait Until Element Is Visible    xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10s
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Lock queue"]    timeout=10s
    Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Lock queue"]
    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="android:id/button1"]    timeout=10s
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]

#Validate and Verify
Validate Empty Queue Message
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/emptyViewTitle    timeout=10s
    Element Text Should Be    id=de.danoeh.antennapod.debug:id/emptyViewTitle    No queued episodes

Verify Single Podcast In Sorted Queue
    [Arguments]    ${title}
    ${items}=    Get WebElements    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="de.danoeh.antennapod.debug:id/recyclerView"]/*
    Length Should Be    ${items}    1
    ${item_text}=    Get Text    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]
    Should Be Equal    ${item_text}    ${title}

Verify Sorted Queue Order
    [Arguments]    ${title1}    ${title2}
    ${items}=    Get WebElements    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="de.danoeh.antennapod.debug:id/recyclerView"]/*
    Length Should Be    ${items}    2
    ${first_title}=    Get Element Attribute    xpath=(//androidx.recyclerview.widget.RecyclerView/android.widget.FrameLayout[1]//android.widget.LinearLayout[@resource-id="de.danoeh.antennapod.debug:id/container"]//android.widget.LinearLayout)[1]    content-desc
    ${second_title}=    Get Element Attribute    xpath=(//androidx.recyclerview.widget.RecyclerView/android.widget.FrameLayout[2]//android.widget.LinearLayout[@resource-id="de.danoeh.antennapod.debug:id/container"]//android.widget.LinearLayout)[1]    content-desc
    Should Be Equal    ${first_title}    ${title1}
    Should Be Equal    ${second_title}    ${title2}

Clear Queue And Verify Empty
    Wait Until Element Is Visible    xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10s
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Clear queue"]    timeout=10s
    Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Clear queue"]
    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="android:id/button1"]    timeout=10s
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/emptyViewTitle    timeout=10s
    Element Text Should Be    id=de.danoeh.antennapod.debug:id/emptyViewTitle    No queued episodes

Verify Queue Locked Message
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/snackbar_text    timeout=10s
    Element Text Should Be    id=de.danoeh.antennapod.debug:id/snackbar_text    Queue locked

Verify Queue Is Locked
    Page Should Not Contain Element    id=de.danoeh.antennapod.debug:id/drag_handle

Verify Podcasts In Queue
    [Arguments]    @{titles}
    FOR    ${title}    IN    @{titles}
        Verify Podcast In Queue    ${title}
    END

# Queue Drag and Drop Keywords
Drag Podcast From To
    [Arguments]    ${source_index}    ${target_index}
    ${source}=    Set Variable    xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/drag_handle"])[${source_index}]
    ${target}=    Set Variable    xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/drag_handle"])[${target_index}]
    Wait Until Element Is Visible    ${source}    timeout=10s
    Wait Until Element Is Visible    ${target}    timeout=10s
    Drag And Drop    ${source}    ${target}

Handle Swipe Confirmation If Exists
    [Documentation]    檢查是否出現滑動提示視窗並處理。
    Run Keyword And Ignore Error    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="android:id/button1"]    timeout=5s
    Run Keyword And Ignore Error    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]

Swipe Right
    [Arguments]    ${title}
    ${locator}=    Set Variable    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]
    # 獲取元素位置和大小
    ${location}=    Get Element Location    ${locator}
    ${size}=        Get Element Size       ${locator}
    
    # 計算滑動起點（元素右側，垂直中間）
    ${start_x}=    Evaluate    ${location['x']} + ${size['width']} - 10
    ${start_y}=    Evaluate    ${location['y']} + ${size['height']} / 2
    
    # 計算滑動終點（元素左側，同一高度）
    ${end_x}=      Evaluate    ${location['x']} + 10
    ${end_y}=      Set Variable    ${start_y}
    
    # 執行滑動（從右到左）
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    500  # duration=500ms

Swipe Right On Element To Remove
    [Arguments]    ${title}
    Swipe Right   ${title}
    Handle Swipe Confirmation If Exists
    Swipe Right   ${title}

Undo Remove Action
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/snackbar_action"]    timeout=10s
    Click Element    xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/snackbar_action" and @text="Undo"]

Verify Podcast In Queue
    [Arguments]    ${title}
    Wait Until Page Contains Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]    timeout=10s
    Page Should Contain Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]

Verify Queue Order
    [Arguments]    ${title1}    ${title2}
    Wait Until Page Contains Element    xpath=(//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle"])[1]    timeout=10s
    ${new_title_1}=    Get Text    xpath=(//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle"])[1]
    ${new_title_2}=    Get Text    xpath=(//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle"])[2]
    Should Be Equal    ${new_title_1}    ${title1}
    Should Be Equal    ${new_title_2}    ${title2}

Verify Remove Action
    Wait Until Page Contains Element    xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/snackbar_action"]    timeout=10s
    Page Should Contain Element    xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/snackbar_action"]
