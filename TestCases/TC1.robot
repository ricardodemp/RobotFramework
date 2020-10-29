#NAO ENVIAR TESTESSSS#ST1: Consultar produtos no site.

*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${browser}  chrome
${url}  http://automationpractice.com/index.php
${invalid_search}  test
${valid_search}  printed

*** Test Cases ***
SearchTest1 - Happy Search
    open browser  ${url}   ${browser}

    maximize browser window

    element should be visible  xpath://input[@id='search_query_top']
    element should be enabled  xpath://input[@id='search_query_top']

    Input Text  xpath://input[@id='search_query_top']  dress
    Press Keys  xpath://input[@id='search_query_top']  ENTER

    #Input Text  xpath://input[@id='Password']  pavanoltraining@gmail.com

    #Click Element  xpath://input[@class='button-1 login-button']

SearchTest2 - Invalid Search
    Input Text  xpath://input[@id='search_query_top']  ${invalid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

    ${message}    Get Text    xpath://p[@class='alert alert-warning']
    Should Be Equal As Strings    ${message}    No results were found for your search "${invalid_search}"

SearchTest3 - Total
    Input Text  xpath://input[@id='search_query_top']  ${valid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

    ${totalmessage}    Get Text    xpath://span[@class='heading-counter']

    ${totalpage}    Get Text    xpath://div[@class='product-count']

    ${countitems} =  Get Element Count   xpath://div[@class='product-image-container']
    Should Be True  ${countitems} == 5

    Should Be Equal As Strings    ${totalmessage}    ${countitems} results have been found.

SearchTest4 - View Grid
    Input Text  xpath://input[@id='search_query_top']  ${valid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

    click Element  xpath://li[@id='grid']
    element should be visible  xpath://div[@class='product-image-container']

SearchTest5 - View List
    Input Text  xpath://input[@id='search_query_top']  ${valid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

    click Element  xpath://li[@id='list']
    element should be visible  xpath://div[@class='product-container']

SearchTest6 - Total Page
    Input Text  xpath://input[@id='search_query_top']  ${valid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

    ${totalpage}    Get Text    xpath://div[@class='product-count']

    ${countitems} =  Get Element Count   xpath://div[@class='product-container']
    Should Be True  ${countitems} == 5

    Should Be Equal As Strings    ${totalpage}     Showing 1 - ${countitems} of ${countitems} items
