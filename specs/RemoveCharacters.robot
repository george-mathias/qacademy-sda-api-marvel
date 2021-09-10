*** Settings ***
Documentation        suite de teste de exclusão de personagens na API da Marvel

Resource   ${EXECDIR}/resources/Base.robot
Library    ${EXECDIR}/resources/factories/Xmen.py
Library    RequestsLibrary

Suite Setup    Super Setup   mathias-george@gmail.com

*** Test Cases ***
Deve remover um personagem pelo id

    ${personagem}           Factory Ciclope
    ${ciclope}              POST New Character        ${personagem}
    ${ciclope_id}           Set Variable              ${ciclope.json()}[_id]

    ${response}             DELETE Character By Id    ${ciclope_id}
    
    Log To Console          ${response}
    Status Should Be        204    ${response}

    ${response2}            GET Character By Id       ${ciclope_id}

    Status Should Be        404    ${response2}

Não deve encontrar o personagem pelo Id inexistente

    ${personagem_id}        Get Unique Id    
    
    ${response}             GET Character By Id    ${personagem_id}
    
    Status Should Be        404    ${response}