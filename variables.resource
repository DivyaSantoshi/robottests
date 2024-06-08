*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${Browser}    chrome
${URL}    https://www.saucedemo.com/
${Username}    standard_user
${Locked_User}    locked_out_user
${Password}    secret_sauce
${Products}    https://www.saucedemo.com/inventory.html
${Error-Message}    Epic sadface: Sorry, this user has been locked out.
