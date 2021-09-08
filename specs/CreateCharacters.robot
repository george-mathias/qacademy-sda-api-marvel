*** Settings ***
Documentation        suite de teste de cadastro de personagens na API da Marvel

Resource   ${EXECDIR}/resources/Base.robot
Library    ${EXECDIR}/resources/factories/Guardians.py

Suite Setup    Super Setup   mathiasgeorge@gmail.com

*** Test Cases ***
Deve cadastrar um personagem

    ${personagem}    Factory Star Lord
        
    ${response}      POST New Character    ${personagem}

    Status Should Be    200    ${response}

Nao deve cadastrar com o mesmo nome
    [Tags]    2

    # Dado que Thanos ja exista no sistema
    ${personagem}    Factory Groot

    POST New Character    ${personagem}

    # Quando faço uma requisiçao POST para a rota characters
    ${response}           POST New Character    ${personagem}   

    # Entao o codigo de retorno deve ser 409
    Status Should Be    409    ${response}

    Should Be Equal    ${response.json()}[error]    Character already exists :(
    