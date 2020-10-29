#ST1: Consultar produtos no site

*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${browser}  chrome
${url}  http://automationpractice.com/index.php
${invalid_search}  test
${valid_search}  printed

*** Test Cases ***
SearchTest1 - Happy Search

    Open Browser Session

    element should be visible  xpath://input[@id='search_query_top']
    element should be enabled  xpath://input[@id='search_query_top']

    Search Valid Product
    Close Browser

SearchTest2 - Invalid Search

    Open Browser Session

    Search Invalid Product
    ${message}    Get Text    xpath://p[@class='alert alert-warning']
    Should Be Equal As Strings    ${message}    No results were found for your search "${invalid_search}"
    Close Browser

SearchTest3 - Total
    Open Browser Session

    Search Valid Product

    ${totalmessage}    Get Text    xpath://span[@class='heading-counter']
    ${totalpage}    Get Text    xpath://div[@class='product-count']
    ${countitems} =  Get Element Count   xpath://div[@class='product-image-container']
    Should Be True  ${countitems} == 5
    Should Be Equal As Strings    ${totalmessage}    ${countitems} results have been found.

    Close Browser

SearchTest4 - View Grid

    Open Browser Session
    Search Valid Product

    click Element  xpath://li[@id='grid']
    element should be visible  xpath://div[@class='product-image-container']

    Close Browser

SearchTest5 - View List

    Open Browser Session

    Search Valid Product
    click Element  xpath://li[@id='list']
    element should be visible  xpath://div[@class='product-container']

    Close Browser

SearchTest6 - Total Page
    Open Browser Session

    Search Valid Product
    ${totalpage}    Get Text    xpath://div[@class='product-count']
    ${countitems} =  Get Element Count   xpath://div[@class='product-container']
    Should Be True  ${countitems} == 5
    Should Be Equal As Strings    ${totalpage}     Showing 1 - ${countitems} of ${countitems} items

    Close Browser

*** Keywords ***
Search Valid Product
    Input Text  xpath://input[@id='search_query_top']  ${valid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

Search Invalid Product
    Input Text  xpath://input[@id='search_query_top']  ${invalid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

Open Browser Session
    open browser  ${url}   ${browser}
    maximize browser window