*** Settings ***
Documentation        suite de teste de cadastro de personagens na API da Marvel

Library    RequestsLibrary
Library    ./factories/Thanos.py


*** Test Cases ***
Deve cadastrar um personagem

    Account And Set Headers    mathiasgeorge@gmail.com

    &{personagem}    Factory Thanos
        
    ${response}      POST
    ...              http://marvel.qaninja.academy/characters
    ...              json=${personagem}
    ...              headers=${headers}

    Status Should Be    200    

*** Keywords ***
Account And Set Headers
    [Arguments]      ${email}
    &{usuario}       Create Dictionary    email=${email}
    ${response}      POST
    ...              http://marvel.qaninja.academy/accounts
    ...              json=${usuario}

    ${client_key}    Set Variable         ${response.json()}[client_key]    
    
    &{HEADERS}       Create Dictionary    client_key=${client_key}

    Set Suite Variable    &{HEADERS}