*** Settings ***
Library    AppiumLibrary
Resource    allLocalKeywords.txt
Resource    Variables.txt

*** Variables ***
${REMOTE_URL}          http://127.0.0.1:4723
${PLATFORM_NAME}       Android
${AUTOMATION_NAME}     UiAutomator2
${DEVICE_NAME}         Android
${APP_PACKAGE}         de.danoeh.antennapod.debug
${APP_ACTIVITY}        de.danoeh.antennapod.activity.MainActivity

*** Test Cases ***
Open App
    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}   deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}

Filter Paused Podcasts
    [Tags]    TC-FP-01    subscription
    [Setup]    Run Keywords    Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    automationName=${AUTOMATION_NAME}    fullReset=${FULL_RESET}    app=${APP}
    ...                 AND    Add Podcast To Subscriptions
    ...                 AND    Play And Pause Podcast    1    isNeedTitle=True
    ...                 AND    Click Back Button In Podcast Information Page
    Filter Paused Podcast
    Verify Filter Is Applied    ${episodeTitleList}[0]
    [Teardown]    Clear Filter And Close Application