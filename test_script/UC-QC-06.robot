*** Settings ***
Library    AppiumLibrary
Library    Process
Resource    ../config/settings.robot
Resource    ../config/variables.robot
Resource    ./keywords/keywords.robot

Test Setup     Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Test Teardown  Reset App And Close

*** Test Cases ***
#TC-QC-06-02
Queue is empty when lock queue

    # 點擊 "Queue" 頁面
    Wait Until Element Is Visible     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]     timeout=10
    Click Element                     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]

    # 驗證是否出現 "No queued episodes"
    Wait Until Element Is Visible     id=de.danoeh.antennapod.debug:id/emptyViewTitle    timeout=5
    Element Text Should Be           id=de.danoeh.antennapod.debug:id/emptyViewTitle    No queued episodes

    Clear Queue and Verify Empty

#TC-QC-06-01
Queue is not empty when lock queue
    Prepare Queue With One Podcast
    # 點擊 "Queue" 頁面
    Wait Until Element Is Visible     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]     timeout=10
    Click Element                     xpath=(//android.widget.ImageView[@resource-id="de.danoeh.antennapod.debug:id/navigation_bar_item_icon_view"])[2]

    Clear Queue and Verify Empty

