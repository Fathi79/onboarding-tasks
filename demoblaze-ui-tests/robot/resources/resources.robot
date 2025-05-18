*** Settings ***
Documentation     Common reusable keywords and setup/teardown logic.
Library           SeleniumLibrary


*** Keywords ***
Open Edge On Landing Page
    [Arguments]    ${landing_page}
    Create Webdriver    Chrome
    Maximize Browser Window
    Go To    ${landing_page}
    Wait Until Page Contains Element    id:cat

Close Edge
    Sleep    2s
    Close Browser


*** Keywords ***
Open Chrome Headless
    [Arguments]    ${random}
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Evaluate    options.add_argument('--headless')    options=${options}
    Evaluate    options.add_argument('--no-sandbox')    options=${options}
    Evaluate    options.add_argument('--disable-dev-shm-usage')    options=${options}
    Evaluate    options.add_argument(f'--user-data-dir=/tmp/chrome-user-data-{random}')    options=${options}    random=${random}
    ${driver}=    Create WebDriver    Chrome    options=${options}



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