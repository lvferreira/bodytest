***Settings***
Documentation       Atualizar Alunos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Atualizar um aluno já cadastrado
    [Tags]      update
    [Teardown]                          ThinkTime
    ${json}    Get JSON    students-update.json

    ${shaokhan}      Set Variable    ${json['before']}
    ${johnnycage}    Set Variable    ${json['after']}

    Remove Student By Name              ${shaokhan['name']}
    Remove Student By Name              ${johnnycage['name']}    

    Insert Student                      ${shaokhan}
    Go To Students
    Search Student By Name              ${shaokhan['name']}   
    Go To Student Update Form           ${shaokhan['email']}
    Update Student                      ${johnnycage}
    Toaster Text Should be              Aluno atualizado com sucesso.

    

