*** Settings ***
Documentation     Test suite for verifying Demoblaze functionality.
Resource          ../resources/resources.robot
Library           SeleniumLibrary
Library           Collections
Library           BuiltIn
Library           String    # For string manipulation

Test Setup        Open Edge On Landing Page    https://www.demoblaze.com/
Test Teardown     Close Edge

*** Test Cases ***

Verify Total Item Count Across All Pages
    [Documentation]    This test case simply count the number of devices appears in the demoblaze website
    Go To Home Page
    ${total_items}=    Get Total Item Count
    Assert Total Count    ${total_items}    15

Verify Item Description and Price
    [Documentation]    This test cases used to verify information of an existing device
    Go To Home Page
    Go To Phone Section
    Validate Item Details    ${item_name}    ${expected_description}    ${expected_price}



