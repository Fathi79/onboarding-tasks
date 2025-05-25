*** Settings ***
Documentation    This  File is to Test APIs of the pet store

Library    Collections
Library    RequestsLibrary
Library    BuiltIn
Resource   ../resources/keywords.robot

*** Test Cases ***

Add A New Pet To The Store
    [Documentation]    A pet should be successfully added to the store and receive a unique ID.
    [Tags]    APIs
    Add A Pet To The Store    9991    bero

View The Newly Added Pet
    [Documentation]    After adding a pet, we should be able to retrieve its details.
    [Tags]    APIs
    Verify The Pet Exists In The Store

Update The Pet's Details
    [Documentation]    The pet's details can be updated after it's created.
    [Tags]    APIs
    Update The Pet Details    bero_updated    sold

Delete The Pet From The Store
    [Documentation]    Once deleted, the pet should no longer be retrievable from the store.
    [Tags]    APIs
    Delete The Pet From The Store

Confirm The Pet Is No Longer Available
    [Documentation]    Trying to view a deleted pet should return an error.
    [Tags]    APIs
    Verify The Pet No Longer Exists
