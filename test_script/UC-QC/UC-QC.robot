*** Settings ***
Resource   ./Setup.robot

*** Variables ***
${PODCAST_TITLE_1}    Haliburton & Pacers shock Thunder in Game 1
${PODCAST_TITLE_2}    NBA Finals Mailbag: Morning Shoot Around
${PODCAST_TITLE_3}    NBA Finals Game 1 Preview

*** Test Cases ***
Verify Single Podcast In Queue
    [Tags]    TC-QC-01
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}
    Go To Queue Page
    Verify Podcast In Queue    ${PODCAST_TITLE_1}
    [Teardown]    Teardown And Clear App

Verify Multiple Podcasts In Queue And Reorder
    [Tags]    TC-QC-02-01
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}    ${PODCAST_TITLE_2}
    Go To Queue Page
    Verify Podcasts In Queue    ${PODCAST_TITLE_1}    ${PODCAST_TITLE_2}
    Drag Podcast From To    1    2
    Verify Queue Order    ${PODCAST_TITLE_2}    ${PODCAST_TITLE_1}
    [Teardown]    Teardown And Clear App

Verify Empty Queue Message
    [Tags]    TC-QC-02-02
    [Setup]    Open AntennaPod
    Go To Queue Page
    Validate Empty Queue Message
    [Teardown]    Teardown And Clear App

Verify No Change On Same Position Drag
    [Tags]    TC-QC-02-03
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}
    Go To Queue Page
    Drag Podcast From To    1    1
    Verify Podcast In Queue    ${PODCAST_TITLE_1}
    [Teardown]    Teardown And Clear App

Remove Podcast From Queue
    [Tags]    TC-QC-03
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_2}
    Go To Queue Page
    Swipe Right On Element To Remove    ${PODCAST_TITLE_2}
    Verify Remove Action   
    [Teardown]    Teardown And Clear App

Restore Removed Podcast 
    [Tags]    TC-QC-04
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_3}
    Go To Queue Page
    Swipe Right On Element To Remove    ${PODCAST_TITLE_3}
    Undo Remove Action
    Verify Podcast In Queue    ${PODCAST_TITLE_3}
    [Teardown]    Teardown And Clear App

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

# robot -i TC-QC-05-01 UC-QC.robot
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

# robot -i TC-QC-07-01 UC-QC.robot
Verify Lock Non-Empty Queue
    [Tags]    TC-QC-07-01
    [Setup]    Run Keywords    Open AntennaPod
    ...                    AND    Add Episode To Queue    ${PODCAST_TITLE_1}
    Go To Queue Page
    Lock Queue
    Verify Queue Is Locked
    [Teardown]    Teardown And Clear App



