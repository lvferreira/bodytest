***Settings***
Documentation       Remover Alunos

Resource            ${EXECDIR}/resources/base.robot

Test Setup          User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Remover aluno cadastrado
    [Teardown]      ThinkTime  2

    &{student}      Create Dictionary   name=Leandro Ferreira     email=leo.ferreira@mail.io     age=34       weight=74      feet_tall=1.68

    Insert Student                  ${student}
    Go To Students
    Search Student By Name          ${student.name}
    Request Removal By Email        ${student.email}
    Confirm Removal
    Toaster Text Should be          Aluno removido com sucesso.
    Student Should Not Be Visible      ${student.email}

Cenario: Desistir da exclusão
    
    &{student}      Create Dictionary   name=Leandro Ferreira     email=leo.ferreira@mail.io    age=34       weight=74      feet_tall=1.68

    Insert Student                  ${student}
    Go To Students
    Search Student By Name          ${student.name}
    #Reload
    Request Removal By Email        ${student.email}
    Cancel Removal
    Student Should Be Visible       ${student.email}
