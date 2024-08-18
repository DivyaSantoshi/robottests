*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    variables.resource

# Add all the locators to the variable file and use the variable name
# Create keywords for all the reusable/repetative code. For e.g "Enter UserName And Password And Login"
# Code in these keywords are similar/common and can be created a seprated keyword and used in both places "Then the products are ordered according to the chosen sort method" and "Then the products are ordered according to the chosen reverse sort method" 
# All the hardcoded values can be assigned to variables in variable file. Avoid harded code values in resource file.

*** Keywords ***
Given Standard Customer Is Logged In    #1.Customer Purchases Products
    Open Browser    ${URL}    ${Browser}
    Enter UserName And Password And Login    ${Username}    ${Password}
    #Input Text    //input[@id="user-name"]    ${Username}  
    #Input Text    //input[@id="password"]    ${Password}
    #Click Button    //input[@id="login-button"]

When Customer Adds Multiple Products To The Shopping Cart
    ${button}    Get WebElements    //button[contains(text(), 'Add to cart')]
    FOR    ${index}    IN RANGE    3
       Click Button    ${button}[${index}]        
    END     

Add Proceeds To Checkout The Purchase
    Wait Until Element Is Visible    //*[@id="shopping_cart_container"]
    Click Link    //*[@id="shopping_cart_container"]/a
    Scroll Element Into View    //*[@id="checkout"]
    Click Button    //button[contains(text(), 'Checkout')]
    Input Text    //*[@placeholder="First Name"]    Jane
    Input Text    //*[@placeholder="Last Name"]    Doe
    Input Text    //*[@placeholder="Zip/Postal Code"]    34563
    Scroll Element Into View    //*[@id="continue"]
    Click Element    //*[@id="continue"]

The Purchase Is Successful
    Scroll Element Into View    //*[@id="finish"]
    Click Button    //button[contains(text(), 'Finish')]
    Page Should Contain    Thank you for your order!

When the customer sorts available products in product view/high to low    #2. Customer Sorts Product Item
    Go To    ${Products}
    Click Element  //*[@id="header_container"]/div[2]//select
    Select From List By Label   //select[@class="product_sort_container"]    Price (high to low)

Then the products are ordered according to the chosen reverse sort method
    ${price_elements}=    Get WebElements    css:.inventory_item_price
    @{prices}=    Create List
    FOR    ${element}    IN    @{price_elements}
           ${price_text}=    Get Text    ${element}
           ${price}=    Convert To Number   ${price_text}[1:]
           Append To List    ${prices}    ${price}
    END
       ${cloned_prices}=    Copy List    ${prices}
       Sort List    ${cloned_prices}
       Reverse List    ${cloned_prices}
       Should Be Equal    ${prices}    ${cloned_prices}

When the customer sorts available products in product view/low to high    #2. Customer Sorts Product Item
    Go To    ${Products}
    Click Element  //*[@id="header_container"]/div[2]//select
    Select From List By Label   //select[@class="product_sort_container"]    Price (low to high)

Then the products are ordered according to the chosen sort method
    ${price_elements}=    Get WebElements    css:.inventory_item_price
    @{prices}=    Create List
    FOR    ${element}    IN    @{price_elements}
           ${price_text}=    Get Text    ${element}
           ${price}=    Convert To Number   ${price_text}[1:]
           Append To List    ${prices}    ${price}
    END
       ${cloned_prices}=    Copy List    ${prices}
       Sort List    ${cloned_prices}
       Should Be Equal    ${prices}    ${cloned_prices}

When the customer attempts to login using proper credentials    #3.User is locked out from the platform
    Open Browser    ${URL}    ${Browser}
    Maximize Browser Window
    Enter UserName And Password And Login    ${Locked_User}    ${Password}

Then login fails
    Wait Until Element Is Visible    css:.error-message-container

And the customer is presented with error state    
   Element Text Should Be    css:.error-message-container    ${Error-Message}

Enter UserName And Password And Login
    [Arguments]    ${username}    ${password}
    Input Text    //input[@id="user-name"]    ${username}
    Input Text    //input[@id="password"]    ${password}
    Click Button    //input[@id="login-button"]
