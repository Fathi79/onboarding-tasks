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
    Go To Home Page
    ${total_items}=    Count All Items Across Pages
    Assert Total Count    ${total_items}    15

Verify Item Description and Price
    Go To Home Page
    Go To Phone Section
    Click Item Card By Name    ${item_name}
    Wait Until Element Is Visible    ${item_description_xpath}    timeout=10s
    ${actual_description}=    Get Text    ${item_description_xpath}
    Log     Actual Description: ${actual_description}
    Wait Until Element Is Visible    ${item_price_css}    timeout=10s
    ${raw_price}=    Get Text    ${item_price_css}
    Log    Raw Price: ${raw_price}
    ${price_parts}=    Split String    ${raw_price}    ${SPACE}
    ${actual_price}=    Set Variable    ${price_parts}[0]
    Log    Parsed Price: ${actual_price}
    Should Be Equal As Strings    ${actual_description}    ${expected_description}    Description mismatch for ${item_name}
    Should Be Equal As Strings    ${actual_price}          ${expected_price}    Price mismatch for ${item_name}


*** Keywords ***
Go To Home Page
    Go To    https://www.demoblaze.com/index.html
    Wait Until Element Is Visible    ${cat_icon}    timeout=10s

Count All Items Across Pages
    @{all_items}=    Create List
    WHILE    True
        ${elements}=    Get WebElements    ${item_cards}
        ${all_items}=    Combine Lists    ${all_items}    ${elements}
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${next_button}
        Run Keyword If    not ${is_visible}    Exit For Loop
        Click Button    ${next_button}
        Sleep    2s
    END
    ${total}=    Get Length    ${all_items}
    Return From Keyword    ${total}

Assert Total Count
    [Arguments]    ${actual}    ${expected}
    Should Be Equal As Integers    ${actual}    ${expected}    Expected ${expected} items but got ${actual}

Go To Phone Section
    Click Element    ${phone_tab}
    Sleep    3s
Get Item Description
    [Arguments]    ${item_name}
    Click Item Card By Name    ${item_name}
    Wait Until Element Is Visible    ${item_description_xpath}    timeout=10s
    ${description}=    Get Text    ${item_description_xpath}
    Return From Keyword    ${description}

Get Item Price
    [Arguments]    ${item_name}
    Click Item Card By Name    ${item_name}
    Wait Until Element Is Visible    ${item_price_css}    timeout=10s
    ${price}=    Get Text    ${item_price_css}
    Return From Keyword    ${price}

Click Item Card By Name
    [Arguments]    ${item_name}
    ${found}=    Set Variable    ${False}
    ${normalized_item_name}=    Evaluate    '${item_name}'.lower().strip()
    WHILE    not ${found}
        ${elements}=    Get WebElements    ${item_cards}
        ${count}=    Get Length    ${elements}
        Log To Console    Found ${count} items on current page
        FOR    ${index}    IN RANGE    1    ${count + 1}
            ${title_xpath}=    Set Variable    (//div[@class='col-lg-4 col-md-6 mb-4'])[${index}]//h4/a
            ${title}=    Get Text    ${title_xpath}
            ${normalized_title}=    Evaluate    '${title}'.lower().strip()
            Log To Console    Checking item: ${title} (Normalized: ${normalized_title})
            ${is_match}=    Evaluate    '${normalized_item_name}' in '${normalized_title}'
            Run Keyword If    ${is_match}    Run Keywords
            Run Keyword If    ${is_match}    Click Element    ${title_xpath}
            Run Keyword If    ${is_match}    Set Test Variable    ${found}    ${True}
            Run Keyword If    ${is_match}    Exit For Loop
        END
        Run Keyword If    ${found}    Exit For Loop
        ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${next_button}
        Run Keyword If    not ${is_visible} and not ${found}    Fail    Item '${item_name}' not found in Phones section
        Run Keyword If    ${is_visible}    Click Button    ${next_button}
        Sleep    2s
    END
