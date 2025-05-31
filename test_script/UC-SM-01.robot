*** Settings ***
Library    AppiumLibrary
Library    Process
Resource    ../config/settings.robot
Resource    ../config/variables.robot
Resource    ./keywords/keywords.robot

Test Setup     Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Test Teardown  Reset App And Close

*** Test Cases ***
# TC-SM-01
Add Channel To Subscription
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

    # 等待並點擊 "Subscribe" 按鈕
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/butSubscribe    timeout=10
    Click Element                    id=de.danoeh.antennapod.debug:id/butSubscribe

    # 點擊 "Subscription" 按鈕
    Wait Until Element Is Visible    xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[4]    timeout=10
    Click Element                    xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[4]

    Wait Until Element Is Visible    xpath=//android.widget.ImageView[@content-desc="The Athletic NBA Daily"]    timeout=10
    Page Should Contain Element     xpath=//android.widget.ImageView[@content-desc="The Athletic NBA Daily"]

