*** Settings ***
Resource   ./Setup.robot
Resource    ../config/settings.robot
Resource    ../config/variables.robot
Resource    ../test_script/keywords/keywords.robot

*** Variables ***
${REMOTE_URL}     http://127.0.0.1:4723
${PLATFORM_NAME}    android
${DEVICE_NAME}    emulator-5554
${PACKAGE_NAME}     de.danoeh.antennapod.debug
${Activity_NAME}    de.danoeh.antennapod.activity.MainActivity

${PODCAST_TITLE_1}    Can the Knicks force game 7?
${PODCAST_TITLE_2}    Thunder advance to NBA Finals
${PODCAST_TITLE_3}    How did we get here? | Morning Shoot Around

*** Test Cases ***
Verify Sort Empty Queue
    [Tags]    TC-QC-05-03
    [Setup]    Open AntennaPod
    Go To Queue Page
    Open Sort Menu
    Select Episode Title Sort
    Close Sort Menu
    Validate Empty Queue Message
    [Teardown]    Teardown And Clear App

Verify Sort Queue With Single Podcast
    [Tags]    TC-QC-05-02
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}
    Go To Queue Page
    Open Sort Menu
    Select Episode Title Sort
    Close Sort Menu
    Verify Single Podcast In Sorted Queue    ${PODCAST_TITLE_1}
    [Teardown]    Teardown And Clear App

Verify Sort Queue With Multiple Podcasts
    [Tags]    TC-QC-05-01
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}    ${PODCAST_TITLE_2}
    Go To Queue Page
    Open Sort Menu
    Select Episode Title Sort
    Close Sort Menu
    Verify Sorted Queue Order    ${PODCAST_TITLE_1}    ${PODCAST_TITLE_2}
    [Teardown]    Teardown And Clear App

Verify Clear Empty Queue
    [Tags]    TC-QC-06-02
    [Setup]    Open AntennaPod
    Go To Queue Page
    Validate Empty Queue Message
    Clear Queue And Verify Empty
    [Teardown]    Teardown And Clear App

Verify Clear Non-Empty Queue
    [Tags]    TC-QC-06-01
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}
    Go To Queue Page
    Clear Queue And Verify Empty
    [Teardown]    Teardown And Clear App

Verify Lock Empty Queue
    [Tags]    TC-QC-07-02
    [Setup]    Open AntennaPod
    Go To Queue Page
    Validate Empty Queue Message
    Lock Queue
    Verify Queue Locked Message
    [Teardown]    Teardown And Clear App

Verify Lock Non-Empty Queue
    [Tags]    TC-QC-07-01
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}
    Go To Queue Page
    Lock Queue
    Verify Queue Is Locked
    [Teardown]    Teardown And Clear App

*** Keywords ***
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

Lock Queue
    Wait Until Element Is Visible    xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10s
    Click Element    xpath=//android.widget.ImageView[@content-desc="More options"]
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Lock queue"]    timeout=10s
    Click Element    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Lock queue"]
    Wait Until Element Is Visible    xpath=//android.widget.Button[@resource-id="android:id/button1"]    timeout=10s
    Click Element    xpath=//android.widget.Button[@resource-id="android:id/button1"]

Verify Queue Locked Message
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/snackbar_text    timeout=10s
    Element Text Should Be    id=de.danoeh.antennapod.debug:id/snackbar_text    Queue locked

Verify Queue Is Locked
    Page Should Not Contain Element    id=de.danoeh.antennapod.debug:id/drag_handle