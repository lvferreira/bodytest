***Settings***
Documentation       Gestão de Planos - Remover Planos

Resource            ${EXECDIR}/resources/base.robot

Test Setup          User Session
Test Teardown       Take Screenshot

***Test Cases***
Cenario: Remover plano cadastrado
     [Tags]     del
    &{plan}         Create Dictionary       title=Plano Del      duration=24     price=10.00
    Insert Plan                      ${plan}
    Go To Plans
    Search Plan By Title             ${plan['title']}
    Request Removal By Title         ${plan['title']}
    Confirm Removal
    Toaster Text Should be           Plano removido com sucesso

Cenario: Desistir da exclusão de Plano
     [Tags]     cancel
    &{plan}         Create Dictionary       title=Plano Cancel     duration=11     price=55.00
    Insert Plan                      ${plan}
    Go To Plans
    Search Plan By Title             ${plan['title']}
    Request Removal By Title         ${plan['title']}
    Cancel Removal
    Plan Should Be Visible           ${plan['title']}