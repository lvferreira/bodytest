***Settings***
Documentation       Buscar Alunos

Resource            ${EXECDIR}/resources/base.robot

Suite Setup         User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Busca Exata
    [Tags]      search
    &{student}          Create Dictionary   name=Leandro Ferreira      email=leo.ferreira@mail.io     age=34       weight=74      feet_tall=1.68

    Remove Student By Name              ${student.name}
    Insert Student                      ${student} 
    Go To Students
    Search Student By Name              ${student.name}    
    Student Name Should Be Visible      ${student.name}
    Total Items Should Be               1

Cenario: Registro Não Encontrado
    [Tags]      not_found
    ${name}             Set Variable    Barão Zemo
    Remove Student By Name              ${name}  
    Go To Students
    Search Student By Name              ${name} 
    Register Should Not Be Found

Cenario: Buscar Alunos Por Um Único Termo
    [Tags]      by_term
    ${fixture}          Get JSON        students-search.json
    ${students}         Set Variable    ${fixture['students']}

    ${word}          Set Variable    ${fixture['word']}
    ${total}         Set Variable    ${fixture['total']}

    Remove Student By Name              ${word}

    #Log to Console      ${json_object['students']}

    FOR     ${item}     IN      @{students}
        Insert Student      ${item}
    END

    Go To Students
    Search Student By Name      ${word} 

    FOR     ${item}     IN      @{students}
        Student Name Should Be Visible      ${item['name']}
    END
    Total Items Should Be       ${total}     
