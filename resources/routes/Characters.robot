*** Settings ***
Documentation        acoes da rota /characters

*** Keywords ***
POST New Character
    [Arguments]    ${payload}

    ${response}    POST        ${API_URL}/characters
    ...            json=${payload}
    ...            headers=${HEADERS}
    ...            expected_status=any

    [Return]    ${response}