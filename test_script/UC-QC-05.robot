*** Settings ***
Library    AppiumLibrary
Library    Process
Resource    ../config/settings.robot
Resource    ../config/variables.robot
Resource    ./keywords/keywords.robot

Test Setup     Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Test Teardown  Reset App And Close

*** Test Cases ***
#TC-QC-05-03
Sort empty queue
    # 點擊 "Queue" 頁面
    Wait Until Element Is Visible     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]     timeout=10
    Click Element                     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]

    # 點選右上角功能欄
    Wait Until Element Is Visible     xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10
    Click Element                     xpath=//android.widget.ImageView[@content-desc="More options"]

    # 點選 "Sort" 選項
    Wait Until Element Is Visible     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]    timeout=10
    Click Element                     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]

    # 點選 "Episode title (ascending)" 選項
    Wait Until Element Is Visible     xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]    timeout=10
    Click Element                     xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]

    # 退出排序選單
    Click Element                     xpath=//android.view.View[@resource-id="de.danoeh.antennapod.debug:id/touch_outside"]

    # 驗證畫面出現 "No queued episodes"
    Wait Until Element Is Visible     id=de.danoeh.antennapod.debug:id/emptyViewTitle    timeout=5
    Element Text Should Be           id=de.danoeh.antennapod.debug:id/emptyViewTitle    No queued episodes

Sort queue with one podcast
    [Tags]    TC-QC-05-02
    Prepare Queue With One Podcast

    # 點擊 "Queue" 頁面
    Wait Until Element Is Visible     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]     timeout=10
    Click Element                     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]

    # 點選右上角功能欄
    Wait Until Element Is Visible     xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10
    Click Element                     xpath=//android.widget.ImageView[@content-desc="More options"]

    # 點選 "Sort" 選項
    Wait Until Element Is Visible     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]    timeout=10
    Click Element                     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]

    # 點選 "Episode title (ascending)" 選項
    Wait Until Element Is Visible     xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]    timeout=10
    Click Element                     xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]

    # 退出排序選單
    Click Element                     xpath=//android.view.View[@resource-id="de.danoeh.antennapod.debug:id/touch_outside"]

    # 驗證畫面出現 "1 queued episode"
    ${items}=    Get WebElements    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="de.danoeh.antennapod.debug:id/recyclerView"]/*
    
    # reecyclerView should have one item => FrameLayout
    Length Should Be    ${items}    1

    # 唯一的 podcast item 應該包含 "Can the Knicks force game 7?"
    ${item_text}=    Get Text    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="Can the Knicks force game 7?"]
    Should Be Equal    ${item_text}    Can the Knicks force game 7?

#TC-QC-05-01
Sort queue with at least two podcasts
    Prepare Queue With Two Podcast

    # 點擊 "Queue" 頁面
    Wait Until Element Is Visible     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]     timeout=10
    Click Element                     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]

    # 點選右上角功能欄
    Wait Until Element Is Visible     xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10
    Click Element                     xpath=//android.widget.ImageView[@content-desc="More options"]

    # 點選 "Sort" 選項
    Wait Until Element Is Visible     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]    timeout=10
    Click Element                     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Sort"]

    # 點選 "Episode title (ascending)" 選項
    Wait Until Element Is Visible     xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]    timeout=10
    Click Element                     xpath=//android.widget.Button[@resource-id="de.danoeh.antennapod.debug:id/button" and @text="Episode title"]

    # 退出排序選單
    Click Element                     xpath=//android.view.View[@resource-id="de.danoeh.antennapod.debug:id/touch_outside"]

    # 驗證畫面出現 "2 queued episode"
    ${items}=    Get WebElements    xpath=//androidx.recyclerview.widget.RecyclerView[@resource-id="de.danoeh.antennapod.debug:id/recyclerView"]/*
    
    # reecyclerView should have one item => FrameLayout
    Length Should Be    ${items}    2

    # 取得第一個節目的標題內容（FrameLayout[1]）
    ${first_title}=    Get Element Attribute    xpath=(//androidx.recyclerview.widget.RecyclerView/android.widget.FrameLayout[1]//android.widget.LinearLayout[@resource-id="de.danoeh.antennapod.debug:id/container"]//android.widget.LinearLayout)[1]    content-desc
    Should Be Equal    ${first_title}    Can the Knicks force game 7?

    # 取得第二個節目的標題內容（FrameLayout[2]）
    ${second_title}=    Get Element Attribute    xpath=(//androidx.recyclerview.widget.RecyclerView/android.widget.FrameLayout[2]//android.widget.LinearLayout[@resource-id="de.danoeh.antennapod.debug:id/container"]//android.widget.LinearLayout)[1]    content-desc
    Should Be Equal    ${second_title}    Thunder advance to NBA Finals




    