*** Settings ***
Documentation     Common reusable keywords and setup/teardown logic.
Library           SeleniumLibrary


*** Keywords ***
Open Edge On Landing Page
    [Arguments]    ${landing_page}
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${uuid}=    Evaluate    __import__('uuid').uuid4().hex
    ${user_data_dir}=    Set Variable    /tmp/chrome-user-data-${uuid}
    ${arg1}=    Set Variable    --user-data-dir=${user_data_dir}
    ${arg2}=    Set Variable    --headless=new
    ${arg3}=    Set Variable    --disable-gpu
    ${arg4}=    Set Variable    --no-sandbox
    ${arg5}=    Set Variable    --disable-dev-shm-usage
    Call Method    ${chrome_options}    add_argument    ${arg1}
    Call Method    ${chrome_options}    add_argument    ${arg2}
    Call Method    ${chrome_options}    add_argument    ${arg3}
    Call Method    ${chrome_options}    add_argument    ${arg4}
    Call Method    ${chrome_options}    add_argument    ${arg5}
    Open Browser    ${landing_page}    chrome    options=${chrome_options}



Close Edge
    Sleep    2s
    Close Browser



Headless Chrome - Open Browser


    Maximize Browser Window


Open Chrome Headless
    [Arguments]    ${random}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Evaluate    options.add_argument('--headless')    options=${options}
    Evaluate    options.add_argument('--no-sandbox')    options=${options}
    Evaluate    options.add_argument('--disable-dev-shm-usage')    options=${options}
    Evaluate    options.add_argument(f'--user-data-dir=/tmp/chrome-user-data-{random}')    options=${options}    random=${random}
    ${driver}=    Create WebDriver    Chrome    options=${options}


Validate Item Details
    [Arguments]    ${item_name}    ${expected_description}    ${expected_price}
    Click Item Card By Name    ${item_name}
    Wait Until Element Is Visible    ${item_description_xpath}    timeout=10s
    ${actual_description}=    Get Text    ${item_description_xpath}

    Wait Until Element Is Visible    ${item_price_css}    timeout=10s
    ${raw_price}=    Get Text    ${item_price_css}
    ${price_parts}=    Split String    ${raw_price}    ${SPACE}
    ${actual_price}=    Set Variable    ${price_parts}[0]

    Should Be Equal As Strings    ${actual_description}    ${expected_description}    Description mismatch for ${item_name}
    Should Be Equal As Strings    ${actual_price}          ${expected_price}         Price mismatch for ${item_name}


Go To Home Page
    Go To    https://www.demoblaze.com/index.html
    Wait Until Element Is Visible    ${cat_icon}    timeout=10s

Get Total Item Count
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






*** Variables ***
${CHROME OPTIONS}    headless
${cat_icon}            id:cat
${item_cards}          xpath://div[@class='col-lg-4 col-md-6 mb-4']
${next_button}         id:next2
${phone_tab}           xpath://a[contains(text(), 'Phones')]
${expected_description}    The HTC One M9 is powered by 1.5GHz octa-core Qualcomm Snapdragon 810 processor and it comes with 3GB of RAM. The phone packs 32GB of internal storage that can be expanded up to 128GB via a microSD card.
${expected_price}          $700
${item_name}               HTC One M9
${item_description_xpath}  xpath://div[@id='more-information']/p
${item_price_css}          css:h3.price-container