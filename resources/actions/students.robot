***Settings***
Documentation       Acoes da feature de gestao de alunos

***Variables***
${NAME_FIELD}          css=input[name=name] 
${EMAIL_FIELD}         css=input[name=email] 
${AGE_FIELD}           css=input[name=age]
${WEIGHT_FIELD}        css=input[name=weight]
${HEIGHT_FIELD}        css=input[name=feet_tall]

**Keywords***
## Forms
Submit Student Form
    #<button color="#4DC097" type="submit" form="formStudent" label="" class="sc-csuQGl iAPAwe"><svg stroke="currentColor" fill="currentColor" stroke-width="0" 
    # viewBox="0 0 24 24" size="24" color="#fff" height="24" width="24" xmlns="http://www.w3.org/2000/svg" style="color: rgb(255, 255, 255);"><path d="M9 16.2L4.8 
    # 12l-1.4 1.4L9 19 21 7l-1.4-1.4L9 16.2z"></path></svg>Salvar</button>
    Click              xpath=//button[contains(text(), "Salvar")]   
    #Click             css=button[form=formStudent]
    #Click             css=button[type=submit]

New Student
    [Arguments]        ${student}

   #<input placeholder="Digite seu nome completo" class="sc-fjdhpX iylogV" id="name" name="name" aria-label="name" value="">
    Fill Text          ${NAME_FIELD}           ${student.name}
    #<input type="email" placeholder="Digite seu endereço de e-Mail" class="sc-fjdhpX iylogV" id="email" name="email" aria-label="email" value="">
    Fill Text          ${EMAIL_FIELD}           ${student.email}
    #<input type="number" placeholder="Sua Idade" class="sc-fjdhpX iylogV" id="age" name="age" aria-label="age" value="">
    Fill Text          ${AGE_FIELD}             ${student.age}
    #<input step="0.01" type="number" placeholder="Seu Peso" class="sc-fjdhpX iylogV" id="weight" name="weight" aria-label="weight" value="">
    Fill Text          ${WEIGHT_FIELD}          ${student.weight}
    #<input step="0.01" type="number" placeholder="Sua Altura" class="sc-fjdhpX iylogV" id="feet_tall" name="feet_tall" aria-label="feet_tall" value="">
    Fill Text          ${HEIGHT_FIELD}          ${student.height}

    Submit Student Form

Update Student
    [Arguments]        ${student}

    Fill Text          ${NAME_FIELD}            ${student['name']}
    Fill Text          ${EMAIL_FIELD}           ${student['email']}
    Fill Text          ${AGE_FIELD}             ${student['age']}
    Fill Text          ${WEIGHT_FIELD}          ${student['weight']}
    Fill Text          ${HEIGHT_FIELD}          ${student['height']}

    Submit Student Form

Search Student By Name
    [Arguments]     ${name}

    Fill Text       css=input[placeholder="Buscar aluno"]       ${name}

## Links & Buttons
Go To Form Student
    # <a color="#4DC097" class="sc-cvbbAY glUTun" href="/alunos/new">
    Click                           css=a[href$="alunos/new"]       
    Wait For Elements State         css=h1 >> text=Novo aluno     visible     5  

Go To Student Update Form
    [Arguments]     ${email}
    #<td class="sc-jKJlTe lanLWo">
    #   <a class="edit" href="/alunos/197/edit" style="color: rgb(80, 114, 188);">
    # <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="edit" class="svg-inline--fa fa-edit fa-w-18 " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">...</svg>
    Click           xpath=//td[contains(text(), "${email}")]/..//a[@class="edit"]
    Wait For Elements State         css=h1 >> text=Edição de aluno     visible     5  

Request Removal By Email
    [Arguments]         ${email}

    Click               xpath=//td[contains(text(), "${email}")]/../td//button[@id="trash"]

    #Table
    # <tr class="sc-ckVGcZ foYhJp">
    #    <td class="sc-jKJlTe lanLWo">Carolina Castro</td>
    #    <td class="sc-jKJlTe lanLWo">carol@test.com</td>
    #    <td class="sc-jKJlTe dLYwSs">35</td>
    #    <td class="sc-jKJlTe lanLWo">
    #        <a class="edit" href="/alunos/96/edit" style="color: rgb(80, 114, 188);"><svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="edit" class="svg-inline--fa fa-edit fa-w-18 " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">...</svg> Editar</a></td>
    #    <td class="sc-jKJlTe lanLWo">
    #        <button color="#4DC097" id="trash" class="sc-gipzik hrUBYS" style="color: rgb(191, 79, 135);">
    #        <span><svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="trash" class="svg-inline--fa fa-trash fa-w-14 " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512">...</svg> Apagar</span></button></td></tr>
    
    # xpath=//td[contains(text(), "carol@test.com")]/../td//button[@id="trash"]

##Checkpoints
Student Should Not Be Visible
    [Arguments]                 ${email}
    Wait For Elements State     xpath=//td[contains(text(), "${email}")]    detached    5

Student Should Be Visible
    [Arguments]                 ${email}
    Wait For Elements State     xpath=//td[contains(text(), "${email}")]    visible     5
     
Student Name Should Be Visible
    [Arguments]         ${name}
    
    Wait For Elements State     css=table tbody tr >> text=${name}          visible     5

