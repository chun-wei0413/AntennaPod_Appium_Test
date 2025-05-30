*** Settings ***
Library    AppiumLibrary
Library    Process
Resource    ../config/settings.robot
Resource    ../config/variables.robot
Resource    ./keywords/keywords.robot

Test Setup     Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    automationName=${AUTOMATION_NAME}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}
Test Teardown  Reset App And Close

*** Test Cases ***
#TC-QC-05-01

#TC-QC-05-02

#TC-QC-05-03
