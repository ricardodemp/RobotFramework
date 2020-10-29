#ST3: Exibir as categorias de produtos no menu da página inicial.

#● Os menus devem ser clicáveis e ao acessá-los os produtos da categoria devem
#ser exibidos.


*** Settings ***
Library  SeleniumLibrary
Library    String

*** Variables ***
${browser}  chrome
${url}  http://automationpractice.com/index.php
${valid_search}  printed

${Menu_women}   xpath://header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/a[1]
${Menu_dresses}   xpath://header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[2]/a[1]
${Menu_tshirts}   xpath://header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[3]/a[1]

${Submenu_title_tops}  xpath://header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/ul[1]/li[1]/a[1]
${Submenu_title_dresses}  xpath://header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/ul[1]/li[2]/a[1]
${Submenu_tshirts}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/ul[1]/li[1]/ul[1]/li[1]/a[1]
${Submenu_blouses}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/ul[1]/li[1]/ul[1]/li[2]/a[1]
${Submenu_women_casual}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/ul[1]/li[2]/ul[1]/li[1]/a[1]
${Submenu_women_evening}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/ul[1]/li[2]/ul[1]/li[2]/a[1]
${Submenu_women_summer}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[1]/ul[1]/li[2]/ul[1]/li[3]/a[1]
${Submenu_dresses_casual}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[2]/ul[1]/li[1]/a[1]
${Submenu_dresses_evening}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[2]/ul[1]/li[2]/a[1]
${Submenu_dresses_summer}  xpath=//header/div[3]/div[1]/div[1]/div[6]/ul[1]/li[2]/ul[1]/li[3]/a[1]

${url_women}  http://automationpractice.com/index.php?id_category=3&controller=category
${url_dresses}  http://automationpractice.com/index.php?id_category=8&controller=category
${url_tshirts}  http://automationpractice.com/index.php?id_category=5&controller=category

*** Test Cases ***

Menus1 - Check Categories
#Aqui apenas um comentário: notei que os menus(labels) estão em maiúsculo e no plural, e o "title" no plural

   Open Browser Session
   Verify Menu Women
   Verify Menu Dresses
   Verify Menu T-shirts

Menus2 - Check Women Submenus

   Verify Submenus Titles
   Verify Submenus Women

Menus3 - Check Dresses Submenus

   Verify Submenus Dresses

Menus4 - Check Menu Pages

   Verify Women Link
   Verify Dresses Link
   Verify T-shirts Link

*** Keywords ***
Open Browser Session
    open browser  ${url}   ${browser}
    maximize browser window

Verify Menu Women
    ${catch title}=  Get Element Attribute    ${Menu_women}  attribute=title
    Should Contain   ${catch title}  Women

Verify Menu Dresses
    ${catch title}=  Get Element Attribute    ${Menu_dresses}  attribute=title
    Should Contain   ${catch title}  Dresses

Verify Menu T-shirts
    ${catch title}=  Get Element Attribute    ${Menu_tshirts}  attribute=title
    Should Contain   ${catch title}  T-shirts

Verify Submenus Titles
    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute        ${Submenu_title_tops}  attribute=title
    Should Contain   ${catch title}  Tops

    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute        ${Submenu_title_dresses}  attribute=title
    Should Contain   ${catch title}  Dresses

Verify Submenus Women
    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_tshirts}  attribute=title
    Should Contain   ${catch title}  T-shirts

    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_blouses}  attribute=title
    Should Contain   ${catch title}  Blouses

    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_women_casual}  attribute=title
    Should Contain   ${catch title}  Casual Dresses

    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_women_evening}  attribute=title
    Should Contain   ${catch title}  Evening Dresses

    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_women_summer}  attribute=title
    Should Contain   ${catch title}  Summer Dresses

Verify Submenus Dresses
    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_dresses_casual}  attribute=title
    Should Contain   ${catch title}  Casual Dresses

    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_dresses_evening}  attribute=title
    Should Contain   ${catch title}  Evening Dresses

    Mouse Over  ${Menu_women}
    ${catch title}=  Get Element Attribute    ${Submenu_dresses_summer}  attribute=title
    Should Contain   ${catch title}  Summer Dresses

Verify Women Link

   Click Element  ${Menu_women}
   ${url}=   Get Location
   Should Contain   ${url}  ${url_women}

Verify Dresses Link
   Click Element  ${Menu_dresses}
   ${url}=   Get Location
   Should Contain   ${url}  ${url_dresses}

Verify T-shirts Link
   Click Element  ${Menu_tshirts}
   ${url}=   Get Location
   Should Contain   ${url}  ${url_tshirts}