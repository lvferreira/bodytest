***Settings***
Documentation       Gestão de Planos - Cadastro de Planos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         User Session
Test Teardown       Take Screenshot


***Test Cases***
Cenario: Novo Plano
    [Tags]  new_plan
    [Teardown]                     ThinkTime
    &{plan}     Create Dictionary       title=Plano Premium      duration=6     price=29,99
    Remove Plan                 ${plan['title']}
    Go To Plans
    Go To Form Plan
    Fill Plan Form              ${plan}
    Submit Plan Form
    Toaster Text Should be         Plano cadastrado com sucesso

Cenario: Calcular preço total do plano
    [Tags]      total_price
    &{plan}     Create Dictionary       title=Plano Premium      duration=12     price=19,99     total=R$ 239,88
    Go To Plans
    Go To Form Plan
    Fill Plan Form          ${plan}
    Total Plan Should Be    ${plan.total}

Cenario: Campo Título deve ser obrigatório
    [Tags]      title
    &{plan}     Create Dictionary       title=${EMPTY}     duration=12     price=19,99
    Go To Plans
    Go To Form Plan
    Fill Plan Form              ${plan}
    Submit Plan Form
    Alert Text Should Be        Informe o título do plano

Cenario: Campo Duração deve ser obrigatório
    [Tags]      duration
    &{plan}     Create Dictionary       title=Plano Premium      duration=${EMPTY}     price=19,99
    Go To Plans
    Go To Form Plan
    Fill Plan Form              ${plan}
    Submit Plan Form
    Alert Text Should Be        Informe a duração do plano em meses

Cenario: Campo Preço Mensal deve ser obrigatório
    [Tags]      monthly_value
    &{plan}     Create Dictionary       title=Plano Premium      duration=6     price=${EMPTY}  
    Go To Plans
    Go To Form Plan
    Fill Plan Form                      ${plan}
    Submit Plan Form
    Alert Text Should Be                O preço é obrigatório

Cenario: Valor do Preço Mensal não pode ser 0,00
    [Tags]      monthly_value>0
    [Teardown]                     ThinkTime
    &{plan}     Create Dictionary       title=Plano Premium      duration=6     price=0,00 
    Go To Plans
    Go To Form Plan
    Fill Plan Form                      ${plan}
    Submit Plan Form
    Toaster Error Text Should be        O valor do plano deve ser maior que zero!

Cenario: Validar todos os campos obrigatórios
    [Tags]      req_fields
    @{expect_alerts}                Set Variable        Informe o título do plano      Informe a duração do plano em meses
    @{got_alerts}                   Create List         
    Go To Plans
    Go To Form Plan
    Submit Plan Form

    FOR     ${index}        IN RANGE    1   3
        ${span}             Get Required Alerts     ${index}
        Append To List      ${got_alerts}          ${span}
    END

    Log     ${expect_alerts}  
    Log     ${got_alerts}  
    Lists should be equal       ${expect_alerts}        ${got_alerts} 

Cenario: Plano deve possuir duração máxima de 60 meses
    [Tags]      exp_date
    &{plan}     Create Dictionary       title=Plano Máximo      duration=61     price=29,99
    Go To Plans
    Go To Form Plan
    Fill Plan Form                 ${plan}
    Submit Plan Form
    Alert Text Should Be           A duração dever ser no máximo 60 meses