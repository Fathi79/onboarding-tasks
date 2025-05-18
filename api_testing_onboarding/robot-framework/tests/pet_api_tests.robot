*** Settings ***
Documentation    This  File is to Test APIs of the pet store

Library    Collections
Library    RequestsLibrary
Library    BuiltIn
Resource   ../Resources/keywords.robot

*** Test Cases ***

Add New Pet
    [Documentation]    This Test Case Tests The POST Pet EndPoint
    [Tags]    APIs
    &{NEW_PET}=    Create Pet Payload    9991    0    dogs    bero
    ...    https://st.depositphotos.com/1007630/2727/i/450/depositphotos_27276047-stock-photo-portrait-of-two-young-beauty.jpg
    ...    1    dog1    available
    Set Global Variable    &{NEW_PET}
    ${payload_response}=    POST    ${PET_END_POINT}    json=${NEW_PET}    expected_status=200
    Should Be Equal As Integers    ${payload_response.json()}[id]    ${NEW_PET}[id]

GET The New Pet
    [Documentation]    This Test Case Tests The GET Pet By Id Endpoint
    [Tags]    APIs
    ${pet_response}=    GET    ${PET_END_POINT}/${NEW_PET}[id]    expected_status=200
    Should Be Equal As Integers    ${pet_response.json()}[id]    ${NEW_PET}[id]
    Should Be Equal As Strings    ${pet_response.json()}[name]    ${NEW_PET}[name]

Update The Pet
    [Documentation]    This Test Case Tests The PUT Pet Endpoint
    [Tags]    APIs
    &{UPDATED_PET}=    Create Pet Payload    ${NEW_PET}[id]    0    dogs    bero_updated
    ...    https://st.depositphotos.com/1007630/2727/i/450/depositphotos_27276047-stock-photo-portrait-of-two-young-beauty.jpg
    ...    1    dog1    sold
    Set Global Variable    &{NEW_PET}    &{UPDATED_PET}
    ${update_response}=    PUT    ${PET_END_POINT}    json=${UPDATED_PET}    expected_status=200
    Should Be Equal As Integers    ${update_response.json()}[id]    ${UPDATED_PET}[id]
    Should Be Equal As Strings     ${update_response.json()}[name]    bero_updated
    Should Be Equal As Strings     ${update_response.json()}[status]  sold

Delete The Pet
    [Documentation]    This Test Case Tests The DELETE Pet By Id Endpoint
    [Tags]    APIs
    ${delete_response}=    DELETE    ${PET_END_POINT}/${NEW_PET}[id]    expected_status=200
    Should Contain    ${delete_response.text}    ${NEW_PET}[id]

Verify Pet Is Deleted
    [Documentation]    This Test Case Verifies That Deleted Pet Cannot Be Retrieved
    [Tags]    APIs
    ${response}=    GET    ${PET_END_POINT}/${NEW_PET}[id]    expected_status=404
    Should Contain    ${response.text}    Pet not found
