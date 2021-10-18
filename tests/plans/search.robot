***Settings***
Documentation       Gestão de Planos - Buscar Planos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Busca exata do plano
     [Tags]     search
    &{plan}     Create Dictionary       title=Plano Busca      duration=8     price=35.89
    Insert Plan                      ${plan}
    Go To Plans
    Search Plan By Title             ${plan['title']}   
    Plan Should Be Visible           ${plan['title']}
    Total Items Should Be               1

Cenario: Registro não encontrado
     [Tags]     not_found
    ${title}        Set Variable     Plano dos Gordinhos
    Go To Plans
    Search Plan By Title             ${title}   
    Register Should Not Be Found

Cenario: Busca planos por um único termo
     [Tags]     by_term
    ${json}       Get JSON        plans-search.json
    
    ${plans}         Set Variable    ${json['plans']}
    ${word}          Set Variable    ${json['word']}
    ${total}         Set Variable    ${json['total']}

    FOR     ${item}     IN      @{plans}
        Insert Plan      ${item}
    END

    Go To Plans
    Search Plan By Title             ${word}  

    FOR     ${item}     IN      @{plans}
        Plan Should Be Visible      ${item['title']}
    END
    Total Items Should Be       ${total}     