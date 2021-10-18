***Settings***
Documentation       Gestão de Planos - Atualizacao de Planos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Atualizar um plano já cadastrado
     [Tags]     update
     [Teardown]                     ThinkTime
    ${json}      Get JSON        plans-update.json

    ${fat}      Set Variable    ${json['before']}
    ${slim}     Set Variable    ${json['after']}

    Remove Plan                      ${fat['title']}
    Remove Plan                      ${slim['title']}

    Insert Plan                      ${fat}
    Go To Plans
    Search Plan By Title             ${fat['title']}   
    Go To Plan Update Form           ${fat['title']} 
    Update Plan                      ${slim} 
    Toaster Text Should be           Plano Atualizado com sucesso