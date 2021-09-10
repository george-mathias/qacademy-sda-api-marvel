*** Settings ***
Documentation        suite de teste de busca de personagens na API da Marvel

Resource   ${EXECDIR}/resources/Base.robot
Library    ${EXECDIR}/resources/factories/Xmen.py
Library    RequestsLibrary

Suite Setup    Super Setup   mathiasgeorge@gmail.com

*** Test Cases ***
Deve buscar um personagem pelo id

    ${personagem}           Factory Logan
    ${logan}                POST New Character   ${personagem}

    ${logan_id}             Set Variable    ${logan.json()}[_id]

    ${response}             GET Character By Id    ${logan_id}
    
    Status Should Be        200    ${response}

    Should Be Equal         ${logan.json()}[name]      ${personagem}[name]
    Should Be Equal         ${logan.json()}[aliases]   ${personagem}[aliases]
    Should Be Equal         ${logan.json()}[age]       ${personagem}[age]
    Should Be Equal         ${logan.json()}[team]      ${personagem}[team]
    Should Be Equal         ${logan.json()}[active]    ${personagem}[active]

Não deve retornar o personagem pelo Id

    ${personagem_id}    Get Unique Id    

    ${response}    GET Character By Id    ${personagem_id}

    Status Should Be    404    ${response}