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


Add A Pet To The Store
    [Arguments]    ${id}    ${name}
    &{NEW_PET}=    Create Pet Payload    ${id}    0    dogs    ${name}
    ...    https://example.com/photo.jpg    1    dog1    available
    Set Global Variable    &{NEW_PET}
    ${response}=    POST    ${PET_END_POINT}    json=${NEW_PET}    expected_status=200
    Should Be Equal As Integers    ${response.json()}[id]    ${NEW_PET}[id]

Verify The Pet Exists In The Store
    ${response}=    GET    ${PET_END_POINT}/${NEW_PET}[id]    expected_status=200
    Should Be Equal As Strings    ${response.json()}[name]    ${NEW_PET}[name]

Update The Pet Details
    [Arguments]    ${new_name}    ${status}
    &{UPDATED_PET}=    Create Pet Payload    ${NEW_PET}[id]    0    dogs    ${new_name}
    ...    https://example.com/photo.jpg    1    dog1    ${status}
    Set Global Variable    &{NEW_PET}    &{UPDATED_PET}
    ${response}=    PUT    ${PET_END_POINT}    json=${UPDATED_PET}    expected_status=200
    Should Be Equal As Strings    ${response.json()}[name]    ${new_name}
    Should Be Equal As Strings    ${response.json()}[status]    ${status}

Delete The Pet From The Store
    ${response}=    DELETE    ${PET_END_POINT}/${NEW_PET}[id]    expected_status=200
    Should Contain    ${response.text}    ${NEW_PET}[id]

Verify The Pet No Longer Exists
    ${response}=    GET    ${PET_END_POINT}/${NEW_PET}[id]    expected_status=404
    Should Contain    ${response.text}    Pet not found
