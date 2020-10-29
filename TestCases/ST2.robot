#ST2: Utilizar o carrinho de compras para adicionar e remover produtos

*** Settings ***
Library  SeleniumLibrary
Library    String

*** Variables ***
${browser}  chrome
${url}  http://automationpractice.com/index.php
${valid_search}  printed

*** Test Cases ***


CartTest1 - Empty Cart

   Open Browser Session

   Click Element  xpath://b[contains(text(),'Cart')]

   ${message}    Get Text    xpath://p[@class='alert alert-warning']
   Should Be Equal As Strings    ${message}    Your shopping cart is empty.

   Close Browser


CartTest2 - Empty Cart

    Open Browser Session

    Search Valid Item

    Click Element  xpath://li[@id='list']
    Click Element  xpath://a[@class='button ajax_add_to_cart_button btn btn-default']

    ${locator checkout}=      Set Variable    xpath://a[@class='btn btn-default button button-medium']
    ${catch title}=  Get Element Attribute    ${locator checkout}  attribute=title
    Should Contain   ${catch title}  Proceed to checkout

    ${locator continue}=      Set Variable    xpath://span[@class='continue btn btn-default button exclusive-medium']
    ${catch title continue}=  Get Element Attribute    ${locator continue}  attribute=title
    Should Contain   ${catch title continue}  Continue shopping

    Close Browser

CartTest3 - Delete Items

    Open Browser Session

    Search Valid Item

    Buy Item

    #CheckOut
    Click Element  xpath://a[@class='btn btn-default button button-medium']

    Delete Item from Cart

    Close Browser

CartTest4 - Total Products

    Open Browser Session

    Search Valid Item

    Buy Item

    #CheckOut
    Click Element  xpath://a[@class='btn btn-default button button-medium']

    Verify Unit Price

    Verify Quantity

    Verify Total Cart

    Verify Total Item

    Close Browser

*** Keywords ***
Open Browser Session
    open browser  ${url}   ${browser}
    maximize browser window

Search Valid Item
    Input Text  xpath://input[@id='search_query_top']  ${valid_search}
    Press Keys  xpath://input[@id='search_query_top']  ENTER

Buy Item
    Click Element  xpath://li[@id='list']
    Click Element  xpath://a[@class='button ajax_add_to_cart_button btn btn-default']
    Element Should Be Enabled  xpath://a[@class='btn btn-default button button-medium']
    Wait Until Keyword Succeeds    1 min    1 sec    Element Should Be Visible    xpath://a[@class='btn btn-default button button-medium']

Delete Item from Cart
    ${delete button}=      Set Variable    xpath://td[@class='cart_delete text-center']
    ${search atribute}=  Get Element Attribute    ${delete button}  attribute=data-title
    Should Contain   ${search atribute}  Delete

    Click Element  ${delete button}
    Page Should Contain Element  xpath://p[contains(text(),'Your shopping cart is empty.')]

Verify Unit Price

    ${search unit price}    Get Text  xpath://span[@class='price special-price']
    ${search unit price}=    Remove String        ${search unit price}  $
    ${unit price}=    Convert To Number    ${search unit price}
    ${result unit price}=   Evaluate    ${search unit price}
    Should Be True  ${result unit price} > 0

Verify Quantity
    ${Quantity}=      Set Variable    xpath://tbody/tr[@id='product_5_19_0_0']/td[5]/input[2]
    ${search Quantity atribute}=  Get Element Attribute    ${Quantity}  attribute=value
    Should Contain   ${search Quantity atribute}  1

Verify Total Item
    ${search total item}    Get Text  xpath://span[@id='total_product_price_5_19_0']
    ${search total item}=    Remove String        ${search total item}  $
    ${item price}=    Convert To Number    ${search total item}
    ${result price}=   Evaluate    ${search total item}
    Should Be True  ${result price} > 0

Verify Total Cart
    ${search price}    Get Text  xpath://span[@id='total_price']
    ${search price}=    Remove String        ${search price}  $
    ${price}=    Convert To Number    ${search price}
    ${result}=   Evaluate    ${search price}
    Should Be True  ${result} > 0
