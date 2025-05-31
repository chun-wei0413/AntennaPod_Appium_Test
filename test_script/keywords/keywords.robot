*** Keywords ***
Reset App And Close
    Run Process    adb    shell    pm clear ${APP_PACKAGE}
    Sleep    1s
    Close Application

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


Prepare Queue With Two Podcast
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

    # 等待並點擊 podcast1 "Can the Knicks force game 7?"
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="Can the Knicks force game 7?"]    timeout=15
    Click Element                    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="Can the Knicks force game 7?"]

    # 點擊 "Stream" 按鈕
    Wait Until Element Is Visible    id=de.danoeh.antennapod.debug:id/butAction1Text    timeout=10
    Click Element                    id=de.danoeh.antennapod.debug:id/butAction1Text

    # 點擊 "Back" icon 退出 該 podcast modal
    Wait Until Element Is Visible    xpath=//android.widget.ImageButton[@content-desc="Back"]    timeout=10
    Click Element                    xpath=//android.widget.ImageButton[@content-desc="Back"]

    # 等待並點擊 podcast2 "Thunder advance to NBA Finals"
    Wait Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="Thunder advance to NBA Finals"]    timeout=15
    Click Element                    xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/txtvTitle" and @text="Thunder advance to NBA Finals"]

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

Clear Queue and Verify Empty
    # 點選右上角功能欄
    Wait Until Element Is Visible     xpath=//android.widget.ImageView[@content-desc="More options"]    timeout=10
    Click Element                     xpath=//android.widget.ImageView[@content-desc="More options"]

    # 點選 "Clear queue"
    Wait Until Element Is Visible     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Clear queue"]    timeout=10
    Click Element                     xpath=//android.widget.TextView[@resource-id="de.danoeh.antennapod.debug:id/title" and @text="Clear queue"]

    # 點選 "Confirm" 按鈕
    Wait Until Element Is Visible     xpath=//android.widget.Button[@resource-id="android:id/button1"]    timeout=10
    Click Element                     xpath=//android.widget.Button[@resource-id="android:id/button1"]

    # 驗證是否出現 "No queued episodes"
    Wait Until Element Is Visible     id=de.danoeh.antennapod.debug:id/emptyViewTitle    timeout=5
    Element Text Should Be           id=de.danoeh.antennapod.debug:id/emptyViewTitle    No queued episodes
