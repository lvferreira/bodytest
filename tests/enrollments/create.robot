***Settings***
Documentation       Gestão de Matrículas - Cadastro de Matrícula

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Deve matricular um aluno em um plano
    [Tags]      enroll
    [Teardown]                  ThinkTime
    ${json}     Get JSON        enroll-create.json

    ${sara}     Set Variable    ${json['student']}
    ${fit}      Set Variable    ${json['plan']}

    Insert Student              ${sara}
    Insert Plan                 ${fit}
 
    Go To Enrolls
    Go To Enrolls Form 
    Select Student              ${sara['name']}
    Select Plan                 ${fit['title']}
    Submit Enrolls Form
    Toaster Text Should be      Matrícula cadastrada com sucesso

Cenario: Deve exibir data inicial e final conforme o plano escolhido
    [Tags]      enroll_dates
    ${json}     Get JSON        enroll-dates.json
    
    ${john}     Set Variable    ${json['student']}
    ${black}    Set Variable    ${json['plan']}

    Insert Student              ${john}
    Insert Plan                 ${black}

    Go To Enrolls
    Go To Enrolls Form
    Select Student              ${john['name']}
    Select Plan                 ${black['title']}
    Start Date Should Be Today
    End Date Should Be          ${json['days']}