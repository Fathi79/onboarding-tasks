*** Settings ***
Documentation    This File is the Resource file for frequently used keywords and Global variables


*** Variables ***
#GLOBAL VARIABLES
${BASE_URL}=    https://petstore.swagger.io/v2
${PET_END_POINT}=    ${BASE_URL}/pet
&{NEW_PET}

*** Keywords ***
# FREQUENTLY USED KEYWORDS
Create Pet Payload
    [Arguments]    ${pet_id}    ${category_id}    ${category_name}    ${pet_name}    ${photo_url}    ${tag_id}    ${tag_name}    ${status}
    &{category}=    Create Dictionary    id=${category_id}    name=${category_name}
    &{tag}=    Create Dictionary    id=${tag_id}    name=${tag_name}
    @{photo_urls}=    Create List    ${photo_url}
    @{tags}=    Create List    ${tag}
    &{pay_load}=    Create Dictionary
    ...    id=${pet_id}
    ...    category=${category}
    ...    name=${pet_name}
    ...    photoUrls=${photo_urls}
    ...    tags=${tags}
    ...    status=${status}
    Return From Keyword    ${pay_load}
