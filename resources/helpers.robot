***Settings***
Documentation       Arquivo que contém funções auxiliares do projeto de automação BodyTest

*** Keywords ***

###Helpers
Get JSON 
    [Arguments]     ${file_name}

    ${file}=            Get File                 ${EXECDIR}/resources/fixtures/${file_name}
    ${json_object}      Evaluate                json.loads($file)       json
    [return]            ${json_object}