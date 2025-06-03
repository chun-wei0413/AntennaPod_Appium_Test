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

${PODCAST_TITLE_1}    Can the Knicks force game 7?
${PODCAST_TITLE_2}    Thunder advance to NBA Finals
${PODCAST_TITLE_3}    How did we get here? | Morning Shoot Around

*** Keywords ***
Open AntennaPod
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=UiAutomator2    deviceName=${DEVICE_NAME}    appPackage=${PACKAGE_NAME}    appActivity=${Activity_NAME}

Teardown And Clear App
    Run Process    adb    shell    pm    clear    ${PACKAGE_NAME}

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
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="The Athletic NBA Daily"]    timeout=10s
    Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="The Athletic NBA Daily"]

    # 遍歷傳入的標題，依次選擇 Podcast
    FOR    ${title}    IN    @{titles}
        # 等待並點擊目標 Podcast
        Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]    timeout=10s
        Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="${title}"]

        # 點擊 "Stream" 按鈕
        Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/butAction1Text    timeout=10s
        Click Element    id=de.danoeh.antennapod.debug:id/butAction1Text

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

Validate Empty Queue Message
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/emptyViewTitle    timeout=10s
    Element Text Should Be    id=de.danoeh.antennapod.debug:id/emptyViewTitle    No queued episodes

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

Verify Podcasts In Queue
    [Arguments]    @{titles}
    FOR    ${title}    IN    @{titles}
        Verify Podcast In Queue    ${title}
    END

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
