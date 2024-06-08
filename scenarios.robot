*** Settings ***
Library    SeleniumLibrary
Resource    variables.resource
Resource    keywords.resource
Suite Setup    Initialize system

*** Keywords ***
Initialize system
    Set Selenium Implicit Wait    0.1
    Set Selenium Speed     0.1

*** Test Cases ***
1. Customer Purchases Products
    Given Standard Customer Is Logged In
    When Customer Adds Multiple Products To The Shopping Cart
    Add Proceeds To Checkout The Purchase
    The Purchase Is Successful

2. Customer sorts product items
    Given standard customer is logged in
    When When the customer sorts available products in product view/high to low
    Then the products are ordered according to the chosen reverse sort method
    When When the customer sorts available products in product view/low to high
    Then the products are ordered according to the chosen sort method

3. User is locked out from the platform
    #Given customer is a locked out customer
    When the customer attempts to login using proper credentials
    Then login fails
    And the customer is presented with error state
    