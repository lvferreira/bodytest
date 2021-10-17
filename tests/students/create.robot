***Settings***
Documentation       Suíte de Cadastro de Alunos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Novo Aluno
    [Tags]      new
    &{student}      Create Dictionary   name=Leandro Ferreira      email=leo.ferreira@mail.io     age=34       weight=74      height=1.68 

    Remove Student             ${student.email}
    Go to Students
    Go to Form Student
    New Student                ${student}        

    #Toaster de Sucesso
    #<div role="alert" class="Toastify__toast-body">Aluno cadastrado com sucesso.</div>
    Toaster Text Should be         Aluno cadastrado com sucesso.

    [Teardown]      ThinkTime  2

Cenario: Não deve permitir email duplicado
    [Tags]      dup
    &{student}      Create Dictionary   name=Leandro Ferreira      email=leo.ferreira@mail.io     age=34       weight=74      height=1.68 

    Insert Student            ${student}
    Go to Students
    Go to Form Student
    New Student               ${student}        

    Toaster Text Should be    Email já existe no sistema.

    [Teardown]       ThinkTime  2

Cenario: Todos os campos devem ser obrigatorios
    [Tags]      req
    @{expect_alerts}                Set Variable        Nome é obrigatório      O e-mail é obrigatório      idade é obrigatória     o peso é obrigatório    a Altura é obrigatória
    @{got_alerts}                   Create List         

    Go to Students
    Go to Form Student
    Submit Student Form

#    FOR         ${alert}    IN      @{expect_alerts}
#    Alert Text Should Be            ${alert}                     
#    END

    FOR     ${index}        IN RANGE    1   6
        ${span}             Get Required Alerts     ${index}
        Append To List      ${got_alerts}          ${span}
    END

    Log     ${expect_alerts}  
    Log     ${got_alerts}  

    Lists should be equal   ${expect_alerts}        ${got_alerts} 

Cenario: Validacao dos campos numericos
    [Tags]      number
    [Template]      Check Field Type On Student Form
    ${AGE_FIELD}          number
    ${WEIGHT_FIELD}       number
    ${HEIGHT_FIELD}       number

Cenario: Validar campo do tipo email
    [Tags]      email
    [Template]      Check Field Type On Student Form
    ${EMAIL_FIELD}        email

Cenario: Validar idade mínima para cadastro
    [Tags]      age
    &{student}      Create Dictionary   name=Leandro Ferreira      email=leo.ferreira@mail.io     age=13       weight=56      height=1.59 

    Go to Students
    Go to Form Student
    New Student             ${student}        
    Alert Text Should Be    A idade deve ser maior ou igual 14 anos


***Keywords***
Check Field Type On Student Form
    [Arguments]             ${element}      ${type}

    Go to Students
    Go to Form Student
    Field Should be Type    ${element}      ${type}
